# frozen_string_literal: true

require "tem_acai/reservation"
RSpec.describe Reservation do
  context "create" do
    it "be true" do
      quantity = 2
      reservation = Reservation.new(quantity)

      expect(reservation.quantity).to eq(quantity)
    end
  end

  context "not create" do
    it "zero" do
      quantity = 0
      reservation = Reservation.new(quantity)

      expect(reservation.quantity).to be_nil
    end

    it "negative" do
      quantity = -1
      reservation = Reservation.new(quantity)

      expect(reservation.quantity).to be_nil
    end
  end
end
