# frozen_string_literal: true

class Reservation
  attr_accessor :quantity

  def initialize(quantity)
    return nil if quantity.zero?
    return nil if quantity.negative?

    @quantity = quantity
  end
end
