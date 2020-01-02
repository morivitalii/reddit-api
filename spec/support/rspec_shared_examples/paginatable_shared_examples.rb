require "rails_helper"

RSpec.shared_examples "paginatable" do
  context "when :attributes option is provided with multiple attributes" do
    it "paginates by provided attributes" do
      models = create_list(factory_name, 3)

      records = described_class.all.paginate(attributes: [:id, :created_at], limit: 2)

      expect(records).to match_array(models[1..-1])
    end
  end

  context "when :order option is provided" do
    context "with :asc" do
      it "orders collection by asc" do
        models = create_list(factory_name, 2)

        records = described_class.all.paginate(order: :asc, limit: 2)

        expect(records).to eq(models)
      end
    end

    context "with :desc" do
      it "orders collection by desc" do
        models = create_list(factory_name, 2)

        records = described_class.all.paginate(order: :desc, limit: 2)

        expect(records).to eq(models.reverse)
      end
    end
  end

  context "when :limit option is provided" do
    it "limits collection" do
      create_list(factory_name, 3)

      records = described_class.all.paginate(limit: 2)

      expect(records.size).to eq(2)
    end
  end

  context "when :after option is provided" do
    it "select records after provided record" do
      models = create_list(factory_name, 3)
      after_id = models[2].id

      records = described_class.all.paginate(after: after_id)

      expect(records).to match_array(models[0..1])
    end
  end

  def factory_name
    described_class.to_s.underscore.to_sym
  end
end
