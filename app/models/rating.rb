# frozen_string_literal: true

class Rating < ApplicationRecord
  belongs_to :customer
  belongs_to :company

  validates :rate, presence: true,
                   numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
end
