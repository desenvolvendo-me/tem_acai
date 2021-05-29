# frozen_string_literal: true

require "csv"

class Provider
  ID_RANDOM_SET = 2000
  DATA_PATH = "data/providers.csv"

  attr_reader :id, :name, :phone

  def initialize(id:, name:, phone: nil)
    @id = id
    @name = name
    @name = name
    @phone = phone
  end

  def self.create(name, phone = nil)
    id = rand(ID_RANDOM_SET)

    new_provider = Provider.new(id: id, name: name, phone: phone)

    return "O nome é obrigatório." if new_provider.name.nil? || new_provider.name == ""

    CSV.open(DATA_PATH, "ab") do |csv|
      csv << [new_provider.id, new_provider.name, new_provider.phone]
    end

    new_provider
  end
end
