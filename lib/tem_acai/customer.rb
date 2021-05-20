# frozen_string_literal: true

require "csv"

# Customer class
class Customer
  def self.create(name, phone)
    return "Por favor, informe seu nome." if name.nil?
    return "Por favor, informe seu telefone." if phone.nil?

    { id: 1, name: name, phone: phone }
  end

  def self.all
    customers = []
    CSV.read("data/customers.csv", headers: true).each do |row|
      customers << { id: row["id"], name: row["name"], phone: row["phone"] }
    end
    customers
  end
end
