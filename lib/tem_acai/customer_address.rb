# frozen_string_literal: true

require "csv"

class CustomerAddress
  ID_RANDOM_SET = 2000
  DATA_PATH = "data/customers-addresses.csv"

  attr_reader :id, :customer_id, :street, :district, :city, :state

  def initialize(id:, customer_id:, street:, district:, city:, state:) # rubocop:disable Metrics/ParameterLists
    @id = id
    @customer_id = customer_id
    @street = street
    @district = district
    @city = city
    @state = state
  end

  def self.create(customer_id:, street:, district:, city:, state:)
    id = rand(ID_RANDOM_SET)
    customer_address = CustomerAddress.new(id: id, customer_id: customer_id, street: street, district: district,
                                           city: city, state: state)

    CSV.open(DATA_PATH, "ab") do |csv|
      csv << [customer_address.id, customer_address.customer_id, customer_address.street,
              customer_address.district, customer_address.city, customer_address.state]
    end

    customer_address
  end
end
