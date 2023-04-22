require 'rails_helper'

RSpec.describe BulkDiscount, type: :model do
  describe "validations" do
    it { should validate_presence_of :merchant_id }
    it { should validate_numericality_of(:discount) }
    it { should validate_numericality_of(:quantity) }
  end

  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many(:items).through(:merchant) }
  end
end
