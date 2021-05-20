# frozen_string_literal: true

require "tem_acai/customer"

RSpec.describe "customer" do
  it "create" do
    name = "fulano"
    phone = "51992345856"
    expect(Customer.create(name, phone)).to eq({ id: 1, name: "fulano", phone: "51992345856" })
  end

  it "throw error message if customer is no name" do
    phone = "51992345856"
    expect(Customer.create(nil, phone)).to eq "Por favor, informe seu nome."
  end

  it "throw error message if customer is no phone" do
    name = "fulano"
    expect(Customer.create(name, nil)).to eq "Por favor, informe seu telefone."
  end

  it "show customers" do
    customers = [
      { id: "1", name: "fulano", phone: "51992345856" },
      { id: "2", name: "beltrano", phone: "112156368947" },
      { id: "1", name: "cicrano", phone: "21996243000" }
    ]
    expect(Customer.all).to eq(customers)
  end
end
