# frozen_string_literal: true

require "rails_helper"

RSpec.describe Rating, type: :model do
  describe "validations" do
    context "rate" do
      it { should validate_presence_of(:rate) }
      it { should allow_values(1, 2, 3, 4, 5).for(:rate) }
      it { should_not allow_value(2.5).for(:rate) }
      it { should_not allow_value(-1, 0, 6).for(:rate) }
    end
  end

  describe "associations" do
    it { should belong_to(:company) }
    it { should belong_to(:customer) }
  end
end
