# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  include StripAttributes

  self.abstract_class = true
end
