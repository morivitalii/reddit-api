module Paginatable
  extend ActiveSupport::Concern

  included do
    def self.paginate(options)
      attributes = options.fetch(:attributes, [:id]).map(&:to_s)
      order = options.fetch(:order, :desc)
      limit = options.fetch(:limit, 50)
      pagination_record = options[:after].present? ? unscoped.find_by_id(options[:after]) : nil

      scope = pagination_scope(attributes, order, limit, pagination_record)
      paginate_scope(scope, limit)
    end

    private

    def self.pagination_scope(attributes, order, limit, pagination_record = nil)
      scope = pagination_limit_scope(limit).pagination_order_scope(attributes, order)

      pagination_record.present? ? scope.pagination_after_scope(attributes, order, pagination_record) : scope
    end

    def self.pagination_limit_scope(limit)
      limit(limit + 1)
    end

    def self.pagination_order_scope(attributes, order)
      options = Hash[attributes.map { |attribute| [attribute, order] }]

      order(options)
    end

    def self.pagination_after_scope(attributes, order, pagination_record)
      columns = attributes.map { |attribute| "#{table_name}.#{attribute}" }.join(",")
      symbol = order == :asc ? ">" : "<"
      fillers = Array.new(attributes.size, "?").join(",")
      values = pagination_record.attributes.slice(*attributes).values

      where("(#{columns}) #{symbol} (#{fillers})", *values)
    end

    def self.paginate_scope(scope, limit)
      records = scope.to_a

      if records.size > limit
        records.delete_at(-1)
        pagination_record = records.last
      end

      [records, pagination_record]
    end
  end
end
