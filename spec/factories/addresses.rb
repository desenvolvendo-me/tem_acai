# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    zip { "MyString" }
    street { "MyString" }
    city { "MyString" }
    state { "MyString" }
  end
end
