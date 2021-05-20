# frozen_string_literal: true

require "csv"
class Company
  ID_RANDOM_SET = 2000
  DATA_PATH = "data/companies.csv"

  attr_reader :id, :name, :phone

  def initialize(id:, name:, phone: "")
    @id = id
    @name = name
    @phone = phone
  end

  def self.all
    companies = []

    CSV.read(DATA_PATH, headers: true).each do |row|
      companies << Company.new(id: row["id"], name: row["name"], phone: row["phone"])
    end
    companies
  end

  def self.create(name:, phone: "")
    id = rand(ID_RANDOM_SET)

    new_company = Company.new(id: id, name: name, phone: phone)

    CSV.open(DATA_PATH, "ab") do |csv|
      csv << [new_company.id, new_company.name, new_company.phone]
    end

    new_company
  end
end
