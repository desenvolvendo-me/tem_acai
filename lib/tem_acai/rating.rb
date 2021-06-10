# frozen_string_literal: true

require "csv"
class Rating
  ID_RANDOM_SET = 2000
  DATA_PATH = "data/ratings.csv"

  attr_reader :id, :rate, :company_id, :customer_id, :content

  def initialize(id:, company_id:, customer_id:, rate:, content: "")
    @id = id
    @company_id = company_id
    @customer_id = customer_id
    @rate = rate
    @content = content
  end

  def valid?
    return false if rate.nil?

    true
  end

  def self.all
    ratings = []

    save_data_rating_to_csv(ratings)

    ratings
  end

  def self.create(company_id:, customer_id:, rate:, content: "")
    id = rand(ID_RANDOM_SET)

    new_rating = Rating.new(id: id, company_id: company_id, customer_id: customer_id, rate: rate, content: content)

    CSV.open(DATA_PATH, "ab") do |csv|
      csv << [new_rating.id, new_rating.company_id, new_rating.customer_id, new_rating.rate, new_rating.content]
    end

    new_rating
  end

  def self.from_company(company_id)
    Rating.all.select { |rating| rating.company_id == company_id }
  end

  def self.save_data_rating_to_csv(ratings)
    CSV.open(DATA_PATH, headers: true).each do |row|
      ratings << Rating.new(id: row["id"], company_id: row["company_id"], customer_id: row["customer_id"],
                            rate: row["rate"], content: row["content"])
    end
  end
end
