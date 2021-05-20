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

  it "show all customers" do
    expect(Customer.all).to eq({ id: 1, name: "fulano", phone: "51992345856" })
  end
end