# frozen_string_literal: true

require "csv"

class Provider
  ID_RANDOM_SET = 2000
  DATA_PATH = "data/providers.csv"

  attr_reader :id, :name

  def initialize(id:, name:)
    @id = id
    @name = name
  end

  def self.create(name)
    id = rand(ID_RANDOM_SET)

    new_provider = Provider.new(id: id, name: name)

    CSV.open(DATA_PATH, "ab") do |csv|
      csv << [new_provider.id, new_provider.name]
    end

    new_provider
  end
end
