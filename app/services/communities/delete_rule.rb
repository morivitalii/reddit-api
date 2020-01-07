class Communities::DeleteRule
  attr_reader :rule

  def initialize(rule)
    @rule = rule
  end

  def call
    rule.destroy!
  end
end
