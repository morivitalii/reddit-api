module Paginatable
  extend ActiveSupport::Concern

  included do
    def self.paginate(options)
      attributes = options[:attributes].map(&:to_s)
      limit = options[:limit]
      order = options[:order]
      order_options = Hash[attributes.map { |attribute| [attribute, order] }]
      scope = limit(limit).order(order_options)

      if options[:after].kind_of?(ActiveRecord::Base)
        after_record = options[:after]
      elsif options[:after].present?
        after_record = unscoped.find_by_id(options[:after])
      else
        after_record = nil
      end

      if after_record.present?
        columns = attributes.map { |attribute| "#{table_name}.#{attribute}" }.join(",")
        symbol = order == :asc ? ">" : "<"
        fillers = Array.new(attributes.size, "?").join(",")
        values = after_record.attributes.slice(*attributes).values

        scope.where("(#{columns}) #{symbol} (#{fillers})", *values)
      else
        scope
      end
    end
  end
end
