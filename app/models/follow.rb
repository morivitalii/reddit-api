class Follow < ApplicationRecord
  belongs_to :user
  belongs_to :followable, polymorphic: true, counter_cache: :followers_count

  validates :user, presence: true, uniqueness: {scope: [:followable_type, :followable_id]}
end
