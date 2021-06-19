# frozen_string_literal: true

FactoryBot.define do
  factory :rating do
    customer { build(:customer) }
    company { build(:company) }
    rate { 4 }
    content { "Nice!" }
  end
end
