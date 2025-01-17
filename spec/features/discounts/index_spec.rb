require 'rails_helper'

RSpec.describe "merchant discounts index" do
  before :each do 
    disc_feat_spec
    visit merchant_discounts_path(@merchant1)
  end

  describe "displays only discounts associated with given merchant" do
    it "displays all the discounts id's, percent discount, and quantity threshold" do
      expect(page).to have_content(@merchant1.name)
      expect(page).to_not have_content(@merchant2.name)
      expect(page).to_not have_content("Discount ##{@discount4.id}")

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

    describe "link to create a new discount" do
      it "has link to new page to create a new discount" do
        expect(page).to have_link("Create New Discount")
        click_link("Create New Discount")
        expect(current_path).to eq(new_merchant_discount_path(@merchant1))

        visit merchant_discounts_path(@merchant2)
        expect(page).to have_link("Create New Discount")
        click_link("Create New Discount")
        expect(current_path).to eq(new_merchant_discount_path(@merchant2))
      end
    end

    describe "button to delete bulk discount" do
      it "has button next to each discount to delete when clicked and redirect to index page" do
        within "#discount-#{@discount1.id}" do 
          expect(page).to have_button("Delete")
          click_on("Delete")
          expect(current_path).to eq(merchant_discounts_path(@merchant1))
        end
        expect(page).to_not have_content(@discount1.id)

        visit merchant_discounts_path(@merchant1)
        within "#discount-#{@discount2.id}" do 
          expect(page).to have_button("Delete")
          click_on("Delete")
          expect(current_path).to eq(merchant_discounts_path(@merchant1))
        end
        expect(page).to_not have_content(@discount2.id)
        visit merchant_discounts_path(@merchant1)
        within "#discount-#{@discount3.id}" do 
          expect(page).to have_button("Delete")
          click_on("Delete")
          expect(current_path).to eq(merchant_discounts_path(@merchant1))
        end
        expect(page).to_not have_content(@discount3.id)
      end
    end
  end

  describe "Holiday api" do
    it "has section with header of upcoming holidays with name and date of 3 upcoming US holidays" do
      within "#upcoming-holidays" do
        expect(page).to have_content("Upcoming Holidays")
        expect(page).to have_content("Memorial Day ~ 2023-05-29")
        expect(page).to have_content("Juneteenth ~ 2023-06-19")
        expect(page).to have_content("Independence Day ~ 2023-07-04")
      end
    end
  end
end