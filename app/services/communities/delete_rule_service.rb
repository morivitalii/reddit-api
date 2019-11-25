class Communities::DeleteRuleService
  attr_reader :rule

  def initialize(rule)
    @rule = rule
  end

  def call
    rule.destroy!
  end
end
