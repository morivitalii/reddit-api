class Communities::Posts::Comments::CreateReport
  include ActiveModel::Model

  attr_accessor :comment, :user, :text

  def call
    return true if comment.ignore_reports?

    attributes = {community: comment.community, text: text}

    comment.reports.create_with(attributes).find_or_create_by!(user: user)
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    false
  end
end
