class Discount < ApplicationRecord
  validates :merchant_id,
            :percent, 
            :threshold, 
            numericality:true, 
            presence:true

  belongs_to :merchant
  has_many :items, through: :merchant
end
