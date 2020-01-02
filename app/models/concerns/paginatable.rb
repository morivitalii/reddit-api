module Paginatable
  extend ActiveSupport::Concern

  included do
    def self.paginate(options)
      attributes = options.fetch(:attributes, [:id]).map(&:to_s)
      order = options.fetch(:order, :desc)
      limit = options.fetch(:limit, 50)
      after_record = options[:after].present? ? unscoped.find_by_id(options[:after]) : nil

      pagination_scope(attributes, order, limit, after_record)
    end

    private

    def self.pagination_scope(attributes, order, limit, after_record = nil)
      order_options = Hash[attributes.map { |attribute| [attribute, order] }]

      scope = limit(limit).order(order_options)

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
