# frozen_string_literal: true

class CreateLog
  def initialize(params)
    @params = params
  end

  def call
    Log.create!(@params)
  end
end
