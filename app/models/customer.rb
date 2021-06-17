# frozen_string_literal: true

class Customer < ApplicationRecord
  validates :name, :phone, presence: true
end
