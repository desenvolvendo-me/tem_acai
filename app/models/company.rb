# frozen_string_literal: true

class Company < ApplicationRecord
  validates :name, presence: true
  validates :phone, presence: true, if: :delivery
end
