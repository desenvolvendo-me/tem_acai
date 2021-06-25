# frozen_string_literal: true

class Address < ApplicationRecord
  validates :zip, :street, :city, :state, presence: true

  has_one :customer, dependent: :nullify
end
