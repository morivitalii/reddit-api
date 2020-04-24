class Communities::Posts::CreateReport
  include ActiveModel::Model

  attr_accessor :post, :user, :text
  attr_reader :report

  def call
    return true if post.ignore_reports?

    attributes = {community: post.community, text: text}

    @report = post.reports.create_with(attributes).find_or_create_by!(user: user)
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    false
  end
end
