# frozen_string_literal: true

require "rails_helper"

RSpec.describe Company, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }

    it "phone is required if delivery is true" do
      company = Company.new(name: "New Company", delivery: true)

      company.valid?

      expect(company.errors["phone"]).to eq(["can't be blank"])
    end
  end

  describe "default values" do
    let(:company) { Company.create(name: "New Company") }

    it "is_open is expected to be false by default" do
      expect(company.is_open).to eq(false)
    end

    it "reservation is expected to be false by default" do
      expect(company.reservation).to eq(false)
    end

    it "deliver is expected to be false by default" do
      expect(company.delivery).to eq(false)
    end
  end
end
