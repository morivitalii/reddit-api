class Communities::ApprovePost
  include ActiveModel::Model

  attr_accessor :post, :user

  def call
    ActiveRecord::Base.transaction do
      post.update!(
        approved_by: user,
        removed_by: nil,
        removed_reason: nil,
        approved_at: Time.current,
        removed_at: nil
      )

      post.reports.destroy_all
    end
  end
end
