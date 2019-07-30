# frozen_string_literal: true

module Bookmarkable
  extend ActiveSupport::Concern

  included do
    attribute :bookmark, default: nil

    has_many :bookmarks, as: :bookmarkable, dependent: :destroy

    def bookmarkable?
      true
    end
  end
end