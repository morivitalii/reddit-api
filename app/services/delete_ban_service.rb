# frozen_string_literal: true

class DeleteBanService
  attr_reader :ban

  def initialize(ban)
    @ban = ban
  end

  def call
    @ban.destroy!
  end
end
