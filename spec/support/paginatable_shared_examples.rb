require "rails_helper"

RSpec.shared_examples_for "paginatable" do
  context "when there is records after last one in collection" do
    it "sets it as a pagination record" do
      create_list(factory_name, 2)

      records, pagination_record = described_class.all.paginate(limit: 1)

      expect(records.last).to eq(pagination_record)
    end
  end

  context "when there is not records after last one in collection" do
    it "sets pagination record to nil" do
      create_list(factory_name, 2)

      _, pagination_record = described_class.all.paginate(limit: 2)

      expect(pagination_record).to be_nil
    end
  end

  context "when :attributes option is provided with multiple attributes" do
    it "paginates by provided attributes" do
      models = create_list(factory_name, 3)

      records, pagination_record = described_class.all.paginate(attributes: [:id, :created_at], limit: 2)

      expect(records).to match_array(models[1..-1])
      expect(pagination_record).to eq(pagination_record)
    end
  end

  context "when :order option is provided" do
    context "with :asc" do
      it "orders collection by asc" do
        models = create_list(factory_name, 2)

        records, _ = described_class.all.paginate(order: :asc, limit: 2)

        expect(records).to eq(models)
      end
    end

    context "with :desc" do
      it "orders collection by desc" do
        models = create_list(factory_name, 2)

        records, _ = described_class.all.paginate(order: :desc, limit: 2)

        expect(records).to eq(models.reverse)
      end
    end
  end

  context "when :limit option is provided" do
    it "limits collection" do
      create_list(factory_name, 3)

      records, _ = described_class.all.paginate(limit: 2)

      expect(records.size).to eq(2)
    end
  end

  context "when :after option is provided" do
    it "select records after provided record" do
      models = create_list(factory_name, 3)
      after_id = models[2].id

      records, _ = described_class.all.paginate(after: after_id)

      expect(records).to match_array(models[0..1])
    end
  end

  def factory_name
    described_class.to_s.underscore.to_sym
  end
end