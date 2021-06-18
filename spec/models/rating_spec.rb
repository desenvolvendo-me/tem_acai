# frozen_string_literal: true

require "rails_helper"

RSpec.describe Rating, type: :model do
  describe "validations" do
    context "rate" do
      it "is valid" do
        rating = build(:rating, rate: 4, content: "Very good!")

        expect(rating.valid?).to eq(true)
      end

      it { should validate_presence_of(:rate) }

      it "is expected to be an integer" do
        rating = build(:rating, rate: 1.25)

        rating.valid?

        expect(rating.errors[:rate]).to include("must be an integer")
      end

      it "is expected to be less or equal to 5" do
        rating = build(:rating, rate: 6)

        rating.valid?

        expect(rating.errors[:rate]).to include("must be less than or equal to 5")
      end

      it "is expected to be greater or equal to 1" do
        rating = build(:rating, rate: 0)

        rating.valid?

        expect(rating.errors[:rate]).to include("must be greater than or equal to 1")
      end
    end
  end
end
