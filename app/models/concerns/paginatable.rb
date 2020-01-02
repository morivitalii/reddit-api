module Paginatable
  extend ActiveSupport::Concern

  included do
    def self.paginate(options)
      attributes = options.fetch(:attributes, [:id]).map(&:to_s)
      order = options.fetch(:order, :desc)
      limit = options.fetch(:limit, 50)
      pagination_record = options[:after].present? ? unscoped.find_by_id(options[:after]) : nil

      pagination_scope(attributes, order, limit, pagination_record)
    end

    private

    def self.pagination_scope(attributes, order, limit, pagination_record = nil)
      order_options = Hash[attributes.map { |attribute| [attribute, order] }]

      scope = limit(limit).order(order_options)

      pagination_record.present? ? scope.pagination_after_scope(attributes, order, pagination_record) : scope
    end

    def self.pagination_after_scope(attributes, order, pagination_record)
      columns = attributes.map { |attribute| "#{table_name}.#{attribute}" }.join(",")
      symbol = order == :asc ? ">" : "<"
      fillers = Array.new(attributes.size, "?").join(",")
      values = pagination_record.attributes.slice(*attributes).values

      where("(#{columns}) #{symbol} (#{fillers})", *values)
    end
  end
end
