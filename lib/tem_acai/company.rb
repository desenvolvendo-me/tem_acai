# frozen_string_literal: true

require "csv"
class Company
  DATA_PATH = "data/companies.csv"

  def self.all
    companies = []

    CSV.read(DATA_PATH, headers: true).each do |row|
      companies << { id: row["id"], name: row["name"], phone: row["phone"] }
    end
    companies
  end

  def self.create(name:, phone: "")
    new_company = { id: 1, name: name, phone: phone }

    companies_csv = CSV.open(DATA_PATH, "ab")

    companies_csv << %w[id name phone] if File.empty?(companies_csv)

    companies_csv << [new_company[:id], new_company[:name], new_company[:phone]]

    new_company
  end
end
