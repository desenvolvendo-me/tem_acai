class Reservation
  attr_accessor :quantity
  def initialize(quantity)
    return nil if quantity.zero?

    @quantity = quantity
  end
end