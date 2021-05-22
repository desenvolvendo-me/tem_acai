# frozen_string_literal: true

require "csv"

# Customer class
class Customer
  ID_RANDOM_SET = 2000
  DATA_PATH = "data/customers.csv"

  attr_reader :id, :name, :phone

  def initialize(id:, name:, phone: "")
    @id = id
    @name = name
    @phone = phone
  end

  def self.create(name, phone)
    id = rand(2000)

    customer = Customer.new(id: id, name: name, phone: phone)
    return "O nome é obrigatório." if customer.name.nil? || customer.name == ""
    return "O telefone é obrigatório." if customer.phone.nil? || customer.phone == ""

    CSV.open(DATA_PATH, "ab") do |csv|
      csv << [customer.id, customer.name, customer.phone]
    end

    customer
  end

  def self.all
    customers = []
    CSV.read(DATA_PATH, headers: true).each do |row|
      customers << { id: row["id"], name: row["name"], phone: row["phone"] }
    end
    customers
  end
end
