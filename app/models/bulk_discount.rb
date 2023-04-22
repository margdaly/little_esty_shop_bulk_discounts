class BulkDiscount < ApplicationRecord
  validates :merchant_id,
            :discount, 
            :quantity, 
            numericality:true, 
            presence:true

  belongs_to :merchant
  has_many :items, through: :merchant
end
