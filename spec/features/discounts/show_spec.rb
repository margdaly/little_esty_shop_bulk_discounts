require 'rails_helper'

RSpec.describe "Bulk Discount Show Page" do
  before :each do 
    disc_feat_spec
  end

  describe "When I visit the Bulk Discount show page" do
    it "displays that discount's threshold and percent discount" do
      visit merchant_discount_path(@merchant1, @discount1)
      expect(page).to have_content("Bulk Discount ##{@discount1.id}")
      expect(page).to_not have_content("Bulk Discount ##{@discount2.id}")
      expect(page).to_not have_content("Bulk Discount ##{@discount3.id}")
      expect(page).to have_content("Quantity Threshold: 6")
      expect(page).to have_content("Percentage Discount: 10.0%")

      visit merchant_discount_path(@merchant2, @discount5)
      expect(page).to have_content("Bulk Discount ##{@discount5.id}")
      expect(page).to_not have_content("Bulk Discount ##{@discount4.id}")
      expect(page).to have_content("Quantity Threshold: 25")
      expect(page).to have_content("Percentage Discount: 25.0%")
    end
  end
end