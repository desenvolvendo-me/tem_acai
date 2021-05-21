# frozen_string_literal: true

require "tem_acai/customer"

RSpec.describe "customer" do
  csv_path = "spec/support/customers-test.csv"

  before do
    stub_const("Customer::DATA_PATH", csv_path)
    restart_csv(csv_path)
  end

  after(:all) { restart_csv(csv_path) }

  it "create" do
    company = Customer.create("fulano", "51992345856")
    expect(company.name).to eq("fulano")
    expect(company.phone).to eq("51992345856")
    expect(company.id).to be_truthy
  end

  it "throw error message if customer is no name" do
    expect(Customer.create(nil, "51992345856")).to eq("O nome é obrigatório.")
    expect(Customer.create("", "51992345856")).to eq("O nome é obrigatório.")
  end

  it "throw error message if customer is no phone" do
    expect(Customer.create("fulano", nil)).to eq("O telefone é obrigatório.")
    expect(Customer.create("fulano", "")).to eq("O telefone é obrigatório.")
  end

  it 'should create 3 customers' do
    Customer.create("ciclano", '11111111111')
    Customer.create("beltrano", '1122222222')
    Customer.create("joao", '3333333333')
    company = Customer.all
    expect(company.length).to eq(3)
  end

  def restart_csv(file_path)
    CSV.open(file_path, "wb") do |csv|
      csv << %w[id name phone]
    end
  end
end
