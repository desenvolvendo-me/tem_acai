require 'rspec'

RSpec.describe Reservation do
  context 'create' do
    it 'be true' do
      quantity = 2
      reservation = Reservation.new(quantity)

      expect(reservation.quantity).to  eq(quantity)
    end
  end
end