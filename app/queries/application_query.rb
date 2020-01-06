class ApplicationQuery
  attr_reader :relation

  def initialize(relation = model_class.all)
    @relation = relation
  end
end
