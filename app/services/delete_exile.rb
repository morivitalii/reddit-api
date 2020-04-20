class DeleteExile
  include ActiveModel::Model

  attr_accessor :exile

  def call
    exile.destroy!
  end
end
