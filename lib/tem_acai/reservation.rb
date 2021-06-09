# frozen_string_literal: true

class Reservation
  attr_accessor :quantity

  def initialize(quantity)
    @quantity = quantity
    nil if quantity.negative?
  end

  def valid?
    return false if self.quantity.zero?
    return false if self.quantity.negative?
    true
  end
end
