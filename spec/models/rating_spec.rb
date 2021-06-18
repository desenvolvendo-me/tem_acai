# frozen_string_literal: true

require "rails_helper"

RSpec.describe Rating, type: :model do
  describe "validations" do
    it { should validate_presence_of(:rate) }
  end
end
