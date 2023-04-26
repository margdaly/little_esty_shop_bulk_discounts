class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: [:cancelled, 'in progress', :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def discounted_revenue 
    #"join invoice items on discounts where the invoice_item quantity is >= discount threshold"
    # sum quantity * unit price / discount.percent
    # require 'pry'; binding.pry
    invoice_items.joins(item: { merchant: :discounts })
    .where('invoice_items.quantity >= discounts.threshold')
    .select("invoice_items.*,  MAX(invoice_items.quantity * invoice_items.unit_price * (discounts.percent / 100)) AS total_discount")
    .group(:id)
    .sum { |invoice_item| invoice_item.total_discount }
  end

  def total_revenue_with_discount
    total_revenue - discounted_revenue
  end
end
