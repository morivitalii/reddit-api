# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  include Sorting

  self.abstract_class = true
end
