# frozen_string_literal: true

require "tem_acai/provider"

RSpec.describe Provider do
  csv_path = "spec/support/providers-test.csv"

  before do
    stub_const("Provider::DATA_PATH", csv_path)
    restart_csv(csv_path)
  end

  after(:all) { restart_csv(csv_path) }

  it ".create name" do
    provider = Provider.create( "Fornecedor 1")
    expect(provider.name).to eq("Fornecedor 1")
  end

  it ".validate name is required" do
    expect(Provider.create( nil)).to eq("O nome é obrigatório.")
    expect(Provider.create( "")).to eq("O nome é obrigatório.")
  end

  def restart_csv(file_path)
    CSV.open(file_path, "ab") do |csv|
      csv << %w[id name]
    end
  end
end
