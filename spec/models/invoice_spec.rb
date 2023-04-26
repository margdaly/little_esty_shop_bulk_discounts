require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "validations" do
    it { should validate_presence_of :status }
    it { should validate_presence_of :customer_id }
  end
  describe "relationships" do
    it { should belong_to :customer }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should have_many :transactions}
  end

  describe "instance methods" do
    before :each do
      @merchant1 = Merchant.create!(name: 'Hair Care')
      @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
      @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
      @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
      @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 2)
      @ii_11 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 1, unit_price: 10, status: 1)

      @customer_14 = Customer.create!(first_name: 'Loey', last_name: 'Pmith')
      @invoice_18 = Invoice.create!(customer_id: @customer_14.id, status: 2, created_at: "2012-03-27 14:54:09")

      @ii_14 = InvoiceItem.create!(invoice_id: @invoice_18.id, item_id: @item_1.id, quantity: 40, unit_price: 10, status: 2)
      @ii_114 = InvoiceItem.create!(invoice_id: @invoice_18.id, item_id: @item_8.id, quantity: 5, unit_price: 10, status: 1)

      @discount1 = @merchant1.discounts.create!(percent: 50, threshold: 5)
      @discount2 = @merchant1.discounts.create!(percent: 25, threshold: 10)
    end

    it "total_revenue" do
      expect(@invoice_1.total_revenue).to eq(100)
      expect(@invoice_18.total_revenue).to eq(450)
    end

    describe "discounted_revenue" do
      it "returns the amount saved from bulk discounts" do
        expect(@invoice_1.discounted_revenue).to eq(45)
        expect(@invoice_18.discounted_revenue).to eq(225)
      end
    end

    describe "total_revenue_with_discount" do
      it "returns total with discount included" do
        expect(@invoice_1.total_revenue_with_discount).to eq(55)
        expect(@invoice_18.total_revenue_with_discount).to eq(225)
      end
    end
  end
end
