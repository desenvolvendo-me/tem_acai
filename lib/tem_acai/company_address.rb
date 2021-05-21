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

  def self.create(company_id:, zip:, street:, city:, state:)
    id = rand(ID_RANDOM_SET)

    new_address = CompanyAddress.new(id: id, company_id: company_id, zip: zip, street: street, city: city,
                                     state: state)

    CSV.open(DATA_PATH, "ab") do |csv|
      csv << [new_address.id, new_address.company_id, new_address.zip, new_address.street, new_address.city,
              new_address.state]
    end

    new_address
  end
end
