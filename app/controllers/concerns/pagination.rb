module Pagination
  extend ActiveSupport::Concern

  included do
    private

    def paginate(relation, options)
      attributes = options[:attributes].map(&:to_s)
      limit = options[:limit]
      order = options[:order]
      order_options = Hash[attributes.map { |attribute| [attribute, order] }]
      scope = relation.limit(limit)
      scope = scope.order(order_options)

      if options[:after].is_a?(ActiveRecord::Base)
        after_record = options[:after]
      elsif options[:after].present?
        after_record = relation.unscoped.where(id: options[:after]).take
      else
        after_record = nil
      end

      if after_record.present?
        columns = attributes.map { |attribute| "#{relation.table_name}.#{attribute}" }.join(",")
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
