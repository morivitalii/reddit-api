class Communities::DeleteRule
  include ActiveModel::Model

  attr_accessor :rule

  def call
    rule.destroy!
  end
end
