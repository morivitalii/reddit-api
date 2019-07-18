class ApplicationPolicy
  attr_reader :context, :record

  def initialize(context, record)
    @context = context
    @record = record
  end

  def user_signed_in?
    context.user.present?
  end
end