# frozen_string_literal: true

require "csv"

# Company holds status asked by the customer
# E.g. Is it opened? Does it has a delivery mode?
class Company
  ID_RANDOM_SET = 2000
  DATA_PATH = "data/companies.csv"

  attr_reader :id, :name, :phone, :is_open, :acai_price, :do_reservation
  attr_accessor :delivery, :reservation, :reservation_max_time
  alias is_open? is_open
  alias do_reservation? do_reservation

  def initialize(id:, name:, phone: "", is_open: false, acai_price: "", do_reservation: false)
    @id = id.to_i
    @name = name
    @phone = phone
    @is_open = ["true", true].include?(is_open)
    @do_reservation = ["true", true].include?(do_reservation)
    @acai_price = acai_price
    @delivery = false
    @reservation = false
  end

  def delivery?
    return "Este estabelecimento não faz entrega." if delivery.eql? false

    "Este estabelecimento faz entrega."
  end

  def reservation?
    return "Este estabelimento não faz reserva." if reservation.eql? false

    "Este estabelecimento faz reserva."
  end

  def addresses
    CompanyAddress.from_company(id.to_s)
  end

  def self.all
    companies = []

    CSV.read(DATA_PATH, headers: true).each do |row|
      companies << Company.new(id: row["id"], name: row["name"], phone: row["phone"], is_open: row["is_open"],
                               acai_price: row["acai_price"], do_reservation: row["do_reservation"])
    end
    companies
  end

  def self.create(name:, phone: "", acai_price: "", address: nil, delivery: false)
    @delivery = delivery
    @address = address
    return "O endereço deve ser obrigatório" unless @address

    id = rand(ID_RANDOM_SET)

    new_company = Company.new(id: id, name: name, phone: phone, acai_price: acai_price)
    new_company.delivery = @delivery

    return "O telefone é obrigatório" if @delivery && (phone.nil? || phone.empty?)
    return "O nome do estabelecimento é obrigatório" if name.nil? || name.empty?

    CSV.open(DATA_PATH, "ab") do |csv|
      csv << [new_company.id, name, new_company.phone, new_company.is_open, new_company.acai_price,
              @delivery, new_company.do_reservation]
    end

    new_company
  end

  def self.sort_by_price
    Company.all.sort_by { |company| company.acai_price&.to_f }
  end

  def self.all_opened
    companies = []
    Company.all.each do |company|
      companies << company if company.is_open.eql? true
    end
    companies
  end

  def self.sort_by_open
    companies = []
    Company.all.each do |company|
      companies << company if company.is_open.eql? true
    end
    companies.sort_by(&:name)
  end

  def inform_open
    self.is_open = is_open.eql?(false) ? true: false

    update_csv
  end

  def inform_closed
    self.is_open = false

    update_csv
  end

  def inform_reservation
    self.do_reservation = do_reservation.eql?(false) ? true : false

    update_csv
  end

  def ratings
    Rating.from_company(id.to_s)
  end

  private

  attr_writer :is_open
  attr_writer :do_reservation

  def update_csv
    companies = Company.all

    save_data_to_csv(companies)
  end

  def save_data_to_csv(companies)
    CSV.open(DATA_PATH, "wb") do |csv|
      csv << %w[id name phone is_open acai_price do_reservation]
      update_csv_for_each_company(companies, csv)
    end
  end

  def update_csv_for_each_company(companies, csv)
    companies.each do |company|
      csv << if company.id.to_i == id
               [id, name, phone, is_open, acai_price, do_reservation]
             else
               [company_id, company.name, company.phone, company.is_open, company.acai_price, company.do_reservation]
             end
    end
  end
end
