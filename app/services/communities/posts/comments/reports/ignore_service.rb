class Communities::Posts::Comments::Reports::IgnoreService
  attr_reader :comment

  def initialize(comment)
    @comment = comment
  end

  def call
    comment.update!(ignore_reports: true)
  end
end
