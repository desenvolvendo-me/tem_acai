# frozen_string_literal: true

require "csv"
class Company
  ID_RANDOM_SET = 2000
  DATA_PATH = "data/companies.csv"

  attr_reader :id, :name, :phone, :is_open
  alias is_open? is_open

  def initialize(id:, name:, phone: "", is_open: false)
    @id = id.to_i
    @name = name
    @phone = phone
    @is_open = ["true", true].include?(is_open)
  end

  def self.all
    companies = []

    CSV.read(DATA_PATH, headers: true).each do |row|
      companies << Company.new(id: row["id"], name: row["name"], phone: row["phone"], is_open: row["is_open"])
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

  def inform_open
    self.is_open = true

    update_csv
  end

  def inform_closed
    self.is_open = false

    update_csv
  end

  def address
    CompanyAddress.from_company(id.to_s)
  end

  def ratings
    Rating.from_company(id.to_s)
  end

  private

  attr_writer :is_open

  def update_csv
    companies = Company.all

    CSV.open(DATA_PATH, "wb") do |csv|
      csv << %w[id name phone is_open]
      companies.each do |company|
        csv << if company.id.to_i == id
                 [id, name, phone, is_open]
               else
                 [company.id, company.name, company.phone, company.is_open]
               end
      end
    end
  end
end
