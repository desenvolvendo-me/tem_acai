# frozen_string_literal: true

require "tem_acai/customer_address"

RSpec.describe CustomerAddress do
  csv_path = "spec/support/customers-addresses-test.csv"

  before do
    stub_const("CustomerAddress::DATA_PATH", csv_path)
    restart_csv(csv_path)
  end

  after(:all) { restart_csv(csv_path) }

  it ".create address of the customer" do
    customer_address = CustomerAddress.create(customer_id: 123, street: "Rua 1, 20", district: "Harmonia",
                                              city: "Canoas", state: "RS")

    expect(customer_address.customer_id).to eq(123)
    expect(customer_address.street).to eq("Rua 1, 20")
    expect(customer_address.district).to eq("Harmonia")
    expect(customer_address.city).to eq("Canoas")
    expect(customer_address.state).to eq("RS")
  end

  it ".validate street" do
    customer_address = CustomerAddress.create(customer_id: 123, street: nil, district: nil,
                                              city: nil, state: nil)
    expect(customer_address).to eq("A rua é obrigatória.")
  end

  it ".validate district" do
    customer_address = CustomerAddress.create(customer_id: 123, street: "Rua 1", district: nil,
                                              city: nil, state: nil)
    expect(customer_address).to eq("O bairro é obrigatório.")
  end

  it ".validate city" do
    customer_address = CustomerAddress.create(customer_id: 123, street: "Rua 1", district: "Osasco",
                                              city: nil, state: nil)
    expect(customer_address).to eq("A cidade é obrigatória.")
  end

  it ".validate state" do
    customer_address = CustomerAddress.create(customer_id: 123, street: "Rua 1", district: "Osasco",
                                              city: "Campinas", state: nil)
    expect(customer_address).to eq("O estado é obrigatório.")
  end

  def restart_csv(file_path)
    CSV.open(file_path, "wb") do |csv|
      csv << %w[id customer_id street district city state]
    end
  end
end
