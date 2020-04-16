class DeleteExile
  attr_reader :exile

  def initialize(exile)
    @exile = exile
  end

  def call
    exile.destroy!
  end
end