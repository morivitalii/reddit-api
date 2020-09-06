class Communities::UpdateBan
  include ActiveModel::Model

  attr_accessor :ban, :updated_by, :end_at

  def call
    ban.update!(
      end_at: end_at,
      updated_by: updated_by
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    false
  end
end
