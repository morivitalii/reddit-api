class Communities::Posts::Comments::DeleteReport
  include ActiveModel::Model

  attr_accessor :report

  def call
    report.destroy!
  end
end
