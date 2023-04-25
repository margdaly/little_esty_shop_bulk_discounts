require 'rails_helper'

RSpec.describe "Bulk Discount Edit Page" do
  before :each do
    disc_feat_spec
    visit edit_merchant_discount_path(@merchant2, @discount5)
  end

  describe "has a form to edit bulk discount" do
    it "the discount's current attributes are pre-populated in the form" do
      expect(page).to have_field("Percent")
      expect(page).to have_field("Threshold")
      expect(find_field("Percent").value).to eq("#{@discount5.percent}")
      expect(find_field("Threshold").value).to eq("#{@discount5.threshold}")
      expect(page).to have_button("Update #{@discount5.id}")
    
      visit edit_merchant_discount_path(@merchant1, @discount3)
      expect(page).to have_field("Percent")
      expect(page).to have_field("Threshold")
      expect(find_field("Percent").value).to eq("#{@discount3.percent}")
      expect(find_field("Threshold").value).to eq("#{@discount3.threshold}")
      expect(page).to have_button("Update #{@discount3.id}")
    end

    it "change any/all of the info, submit, and be redirected to show page where updated attributes are displayed" do
      click_on "Update #{@discount5.id}"
      expect(current_path).to eq(merchant_discount_path(@merchant2, @discount5))
      expect(page).to have_content("Discount Updated! Nice!")
      expect(page).to have_content("Quantity Threshold: 25")
      expect(page).to have_content("Percentage Discount: 25.0%")

      visit edit_merchant_discount_path(@merchant2, @discount5)
      fill_in "Percent", with: 20
      click_on "Update #{@discount5.id}"

      expect(current_path).to eq(merchant_discount_path(@merchant2, @discount5))
      expect(page).to have_content("Discount Updated! Nice!")
      expect(page).to have_content("Quantity Threshold: 25")
      expect(page).to have_content("Percentage Discount: 20.0%")

      visit edit_merchant_discount_path(@merchant2, @discount5)
      fill_in "Percent", with: 40
      fill_in "Threshold", with: 40
      click_on "Update #{@discount5.id}"

      expect(current_path).to eq(merchant_discount_path(@merchant2, @discount5))
      expect(page).to have_content("Discount Updated! Nice!")
      expect(page).to have_content("Quantity Threshold: 40")
      expect(page).to have_content("Percentage Discount: 40.0%")
    end
  end
end