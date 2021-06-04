# frozen_string_literal: true

require "csv"
class CompanyAddress
  ID_RANDOM_SET = 2000
  DATA_PATH = "data/companies-addresses.csv"

  attr_reader :id, :company_id, :zip, :street, :city, :state

  def initialize(id:, company_id:, zip:, street:, city:, state:) # rubocop:disable Metrics/ParameterLists
    @id = id
    @company_id = company_id
    @zip = zip
    @street = street
    @city = city
    @state = state
  end

  def self.all
    addresses = []

    CSV.read(DATA_PATH, headers: true).each do |row|
      addresses << CompanyAddress.new(id: row["id"], company_id: row["company_id"], zip: row["zip"],
                                      street: row["street"], city: row["city"], state: row["state"])
    end
    addresses
  end

  def self.create(company_id:, zip:, street:, city:, state:)
    id = rand(ID_RANDOM_SET)

    new_address = CompanyAddress.new(id: id, company_id: company_id, zip: zip, street: street, city: city,
                                     state: state)

    return "O cep é obrigatório" if new_address.zip.nil? || new_address.zip.empty?
    return "O estado é obrigatório" if new_address.state.nil? || new_address.state.empty?
    return "A cidade é obrigatória" if new_address.city.nil? || new_address.city.empty?
    return "A rua é obrigatória" if new_address.street.nil? || new_address.street.empty?

    save_data_to_csv(new_address)

    new_address
  end

  def self.from_company(company_id)
    CompanyAddress.all.find { |address| address.company_id == company_id }
  end

  def self.save_data_to_csv(new_address)
    CSV.open(DATA_PATH, "ab") do |csv|
      csv << [new_address.id, new_address.company_id, new_address.zip, new_address.street, new_address.city,
              new_address.state]
    end
  end
end
