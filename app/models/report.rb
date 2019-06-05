# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :thing, counter_cache: true
  belongs_to :user

  after_create :reset_thing_approval_attributes_on_create
  after_create :create_or_update_mod_queue_on_create

  validates :text, presence: true, length: { maximum: 500 }

  private

  def reset_thing_approval_attributes_on_create
    thing.reset_approval_attributes
    thing.save!
  end

  def create_or_update_mod_queue_on_create
    if thing.mod_queue.present?
      thing.mod_queue.update!(queue_type: :reported)
    else
      thing.create_mod_queue!(queue_type: :reported)
    end
  end
end
