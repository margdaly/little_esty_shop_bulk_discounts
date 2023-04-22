require 'rails_helper'

RSpec.describe Discount, type: :model do
  describe "validations" do
    it { should validate_presence_of :merchant_id }
    it { should validate_presence_of :percent }
    it { should validate_numericality_of(:percent) }
    it { should validate_presence_of :threshold } 
    it { should validate_numericality_of(:threshold) }
  end

  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many(:items).through(:merchant) }
  end
end
