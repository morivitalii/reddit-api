class Communities::DeleteTag
  include ActiveModel::Model

  attr_accessor :tag

  def call
    tag.destroy!
  end
end
