require 'rails_helper'

describe "merchant discounts index" do
  before :each do 
    disc_feat_spec
    visit merchant_discounts_path(@merchant1)
  end

  describe "displays only discounts associated with given merchant" do
    it "displays all the discounts id's, percent discount, and quantity threshold" do
      expect(page).to have_content(@merchant1.name)
      expect(page).to_not have_content(@merchant2.name)
      expect(page).to_not have_content(@discount4.id)

      within "#discount-#{@discount1.id}" do 
        expect(page).to have_content("Discount ##{@discount1.id}")
        expect(page).to have_content("10% Off")
        expect(page).to have_content("Quantity of 6")
      end
      within "#discount-#{@discount2.id}" do 
        expect(page).to have_content("Discount ##{@discount2.id}")
        expect(page).to have_content("20% Off")
        expect(page).to have_content("Quantity of 12")
      end
      within "#discount-#{@discount3.id}" do 
        expect(page).to have_content("Discount ##{@discount3.id}")
        expect(page).to have_content("30% Off")
        expect(page).to have_content("Quantity of 50")
      end
    end

    it "has link to each discount's show page" do
      expect(page).to_not have_link("#{@discount4.id}")

      within "#discount-#{@discount1.id}" do 
        expect(page).to have_link(@discount1.id)
        click_on(@discount1.id)
        expect(current_path).to eq(merchant_discount_path(@merchant1, @discount1))
      end

      visit merchant_discounts_path(@merchant1)
      within "#discount-#{@discount2.id}" do 
        expect(page).to have_link(@discount2.id)
        click_on(@discount2.id)
        expect(current_path).to eq(merchant_discount_path(@merchant1, @discount2))
      end

      visit merchant_discounts_path(@merchant1)
      within "#discount-#{@discount3.id}" do 
        expect(page).to have_link(@discount3.id)
        click_on(@discount3.id)
        expect(current_path).to eq(merchant_discount_path(@merchant1, @discount3))
      end
    end

    describe 'link to create a new discount' do
      it 'has link to new page to create a new discount' do
        expect(page).to have_link("Create New Discount")
      end
    end
  end
end