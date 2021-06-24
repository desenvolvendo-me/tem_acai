# frozen_string_literal: true

class Company < ApplicationRecord
  belongs_to :address
  accepts_nested_attributes_for :address

  validates :name, presence: true
  validates :phone, presence: true, if: :delivery
end
