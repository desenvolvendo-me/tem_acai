# frozen_string_literal: true

require "tem_acai/reservation"
RSpec.describe Reservation do
  csv_path = "spec/support/reservation-test.csv"

  before do
    @reservation = Reservation.new(2, 1, 1, 2)
    stub_const("Reservation::DATA_PATH", csv_path)
    restart_csv(csv_path)
  end

  after(:all) { restart_csv(csv_path) }

  context "create" do
    it "reservation" do

      expect(@reservation.quantity).to eq 2
      expect(@reservation.company_id).to eq 1
      expect(@reservation.customer_id).to eq 1
      expect(@reservation.time_to_take).to eq 2
    end

    it "be true" do
      @reservation.quantity = 2

      expect(@reservation.quantity).to eq(2)
      expect(@reservation.valid?).to eq(true)
    end
  end

  context "not create" do
    it "zero" do
      @reservation.quantity = 0

      expect(@reservation.valid?).to eq(false)
    end

    it "negative" do
      @reservation.quantity = -1

      expect(@reservation.valid?).to eq(false)
    end
  end

  def restart_csv(file_path)
    CSV.open(file_path, "wb") do |csv|
      csv << %w[id customer_id company_id quantity time_to_take]
    end
  end
end
