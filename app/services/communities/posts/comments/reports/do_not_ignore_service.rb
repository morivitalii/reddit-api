class Communities::Posts::Comments::Reports::DoNotIgnoreService
  attr_reader :comment

  def initialize(comment)
    @comment = comment
  end

  def call
    comment.update!(ignore_reports: false)
  end
end
