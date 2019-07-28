require "rails_helper"

RSpec.shared_examples_for "paginatable" do
  describe ".paginate" do
    let!(:models) { create_list(described_class.to_s.underscore.to_sym, 4) }

    it "return records paginated by one attribute" do
      expected_records = models[0..1]
      expected_pagination_record = models[1]

      records, pagination_record = described_class.paginate(attribute: [:id], order: :asc, limit: 2)

      expect(records).to eq(expected_records)
      expect(pagination_record).to eq(expected_pagination_record)
    end

    it "return records paginated by set of attributes" do
      expected_records = models[0..1]
      expected_pagination_record = models[1]

      records, pagination_record = described_class.paginate(attribute: [:id, :created_at], order: :asc, limit: 2)

      expect(records).to eq(expected_records)
      expect(pagination_record).to eq(expected_pagination_record)
    end

    it "return records paginated by asc order" do
      expected_records = models[0..1]
      expected_pagination_record = models[1]

      records, pagination_record = described_class.paginate(order: :asc, limit: 2)

      expect(records).to eq(expected_records)
      expect(pagination_record).to eq(expected_pagination_record)
    end

    it "return records paginated by desc order" do
      expected_records = models.reverse[0..1]
      expected_pagination_record = models.reverse[1]

      records, pagination_record = described_class.paginate(order: :desc, limit: 2)

      expect(records).to eq(expected_records)
      expect(pagination_record).to eq(expected_pagination_record)
    end

    it "return records paginated by limit" do
      expected_records = models[0..2]
      expected_pagination_record = models[2]

      records, pagination_record = described_class.paginate(order: :asc, limit: 3)

      expect(records).to eq(expected_records)
      expect(expected_pagination_record).to eq(pagination_record)
    end

    it "return records paginated with provided after option" do
      expected_records = models[1..2]
      expected_pagination_record = models[2]
      after_id = models[0].id

      records, pagination_record = described_class.paginate(after: after_id, order: :asc, limit: 2)

      expect(records).to eq(expected_records)
      expect(pagination_record).to eq(expected_pagination_record)
    end

    it "return records paginated without provided after option" do
      expected_records = models[0..1]
      expected_pagination_record = models[1]
      after_id = nil

      records, pagination_record = described_class.paginate(after: after_id, order: :asc, limit: 2)

      expect(records).to eq(expected_records)
      expect(pagination_record).to eq(expected_pagination_record)
    end
  end
end