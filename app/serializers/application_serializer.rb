class ApplicationSerializer
  def initialize(model)
    @model = model
  end

  def self.serialize(object)
    if object.is_a?(Enumerable)
      object.map { |object| new(object) }
    else
      new(object)
    end
  end

  def as_json(options = {})
    attributes
  end

  private

  attr_reader :model
end