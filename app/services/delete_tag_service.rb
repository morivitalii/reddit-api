# frozen_string_literal: true

class DeleteTagService
  attr_reader :tag

  def initialize(tag)
    @tag = tag
  end

  def call
    tag.destroy!
  end
end
