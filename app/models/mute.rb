class Mute < ApplicationRecord
  belongs_to :source, polymorphic: true
  belongs_to :target, polymorphic: true
  belongs_to :created_by, polymorphic: true
  belongs_to :updated_by, polymorphic: true

  validates :source, presence: true
  validates :source_id, presence: true, uniqueness: {scope: [:source_type, :target_type, :target_id]}
  validates :target, presence: true
  validates :created_by, presence: true
  validates :updated_by, presence: true
  validates :end_at, presence: true
end
