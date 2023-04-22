class DiscountsController < ApplicationController
  before_action :find_discount_and_merchant, only: [:show]
  before_action :find_merchant, only: [:new, :index]

  def index
    @discounts = @merchant.discounts
  end

  def show
  end

  def new
  end

  private
  def discount_params
    params.require(:discount).permit(:percent, :threshold, :merchant_id)
  end

  def find_discount_and_merchant
    @discount = Discount.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end