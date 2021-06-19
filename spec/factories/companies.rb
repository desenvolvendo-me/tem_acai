# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    name { "Toca do Acai" }
    phone { "(11) 1111-1111" }
    is_open { false }
    acai_price { 9.99 }
    reservation { false }
    delivery { false }
  end
end
