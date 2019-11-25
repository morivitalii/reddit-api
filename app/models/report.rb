class Report < ApplicationRecord
  include Paginatable

  belongs_to :community
  belongs_to :reportable, polymorphic: true
  belongs_to :user

  validates :text, presence: true, length: {maximum: 500}
end
