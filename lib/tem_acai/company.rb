# frozen_string_literal: true

require "csv"
class Company
  ID_RANDOM_SET = 2000
  DATA_PATH = "data/companies.csv"

  attr_reader :id, :name, :phone, :is_open, :acai_price
  attr_accessor :delivery
  alias is_open? is_open

  def initialize(id:, name:, phone: "", is_open: false, acai_price: "")
    @id = id.to_i
    @name = name
    @phone = phone
    @is_open = ["true", true].include?(is_open)
    @acai_price = acai_price
    @delivery = false
  end

  def delivery?
    return "Este estabelecimento não faz entrega." if delivery == false

    "Este estabelecimento faz entrega."
  end

  def self.all
    companies = []

    CSV.read(DATA_PATH, headers: true).each do |row|
      companies << Company.new(id: row["id"], name: row["name"], phone: row["phone"], is_open: row["is_open"],
                               acai_price: row["acai_price"])
    end
    companies
  end

  def self.create(name:, phone: "", acai_price: "")
    id = rand(ID_RANDOM_SET)

    new_company = Company.new(id: id, name: name, phone: phone, acai_price: acai_price)

    return "O telefone é obrigatório" unless new_company.delivery

    CSV.open(DATA_PATH, "ab") do |csv|
      csv << [new_company.id, new_company.name, new_company.phone, new_company.is_open, new_company.acai_price,
              new_company.delivery]
    end

    new_company
  end

  def self.sort_by_price
    Company.all.sort_by { |company| company.acai_price&.to_f }
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
      csv << %w[id name phone is_open acai_price]
      companies.each do |company|
        csv << if company.id.to_i == id
                 [id, name, phone, is_open, acai_price]
               else
                 [company.id, company.name, company.phone, company.is_open, company.acai_price]
               end
      end
    end
  end
end
