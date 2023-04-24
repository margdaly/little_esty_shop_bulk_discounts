require 'rails_helper'

RSpec.describe "new merchant discount" do
  before :each do 
    disc_feat_spec
    visit new_merchant_discount_path(@merchant1)
  end

  describe "has a form to create a new bulk discount" do
    it "has fields for percent and threshold" do
      expect(page).to have_content(@merchant1.name)
      expect(page).to have_content("My New Bulk Discount")
      expect(page).to have_field('Percent')
      expect(page).to have_field('Threshold')
      expect(page).to have_button('Create New Bulk Discount')
    end

    it "must be filled in with valid data" do
      fill_in 'Percent', with: "Twelve"
      fill_in 'Threshold', with: 10
      click_button 'Create New Bulk Discount'

      expect(current_path).to eq(new_merchant_discount_path(@merchant1))
      expect(page).to have_content("That's Not Quite Right! Try Again, if you wish!")

      fill_in 'Percent', with: 12
      fill_in 'Threshold', with: 'Ten'
      click_button 'Create New Bulk Discount'

      expect(current_path).to eq(new_merchant_discount_path(@merchant1))
      expect(page).to have_content("That's Not Quite Right! Try Again, if you wish!")
    end

    it "filled form will redirect to discount index and new discount displayed" do
      fill_in 'Percent', with: 25
      fill_in 'Threshold', with: 30
      click_button 'Create New Bulk Discount'

      expect(current_path).to eq(merchant_discounts_path(@merchant1))
      expect(page).to have_content("Congrats on your New Bulk Discount!")
      expect(page).to have_content("25% Off")
      expect(page).to have_content("Quantity of 30")
    end
  end
end