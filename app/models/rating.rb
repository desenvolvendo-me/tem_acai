# frozen_string_literal: true

class Rating < ApplicationRecord
  belongs_to :customer
  belongs_to :company
end
