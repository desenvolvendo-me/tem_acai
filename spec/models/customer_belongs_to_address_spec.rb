
RSpec.describe Customer, type: :model do
  describe "Associations" do
    it { should belong_to(:address).without_validating_presence }
  end
end
