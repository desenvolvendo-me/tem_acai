# frozen_string_literal: true

require "csv"

# Rating is responsible for rate companies by the customer
# As a customer, we would like to know which is the best company to buy the product.
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
    return false unless rate

    true
  end

  def self.all
    ratings = []

    save_data_rating_to_csv(ratings)

    ratings
  end

  def self.create(company_id:, customer_id:, rate:, content: "")
    id = rand(ID_RANDOM_SET)

    new_rating = get_new_rating(company_id, content, customer_id, id, rate)

    return unless new_rating.valid?

    CSV.open(DATA_PATH, "ab") do |csv|
      csv << [id, company_id, customer_id, rate, content]
    end

    new_rating
  end

  def self.from_company(company_id)
    Rating.all.select { |rating| rating.company_id == company_id }
  end

  def self.save_data_rating_to_csv(ratings)
    CSV.open(DATA_PATH, headers: true).each do |row|
      ratings << get_new_rating(row["company_id"], row["content"], row["customer_id"], row["id"], row["rate"])
    end
  end

  def self.get_new_rating(company_id, content, customer_id, id, rate)
    Rating.new(id: id, company_id: company_id, customer_id: customer_id, rate: rate, content: content)
  end
end
