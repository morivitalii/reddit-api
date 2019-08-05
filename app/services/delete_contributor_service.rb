# frozen_string_literal: true

class DeleteContributorService
  attr_reader :contributor

  def initialize(contributor)
    @contributor = contributor
  end

  def call
    contributor.destroy!
  end
end
