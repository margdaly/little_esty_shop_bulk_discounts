class DiscountsController < ApplicationController
  before_action :find_discount_and_merchant, only: [:show, :destroy, :edit, :update]
  before_action :find_merchant, only: [:new, :index, :create]

  def index
    @discounts = @merchant.discounts
    @holidays = HolidayBuilder.next_3_holidays
  end

  def show
  end

  def edit
  end
  
  def update
    @discount.update(discount_params)
    flash.notice = "Discount Updated! Nice!"
    redirect_to merchant_discount_path(@merchant, @discount)
  end

  def new
  end

  def create
   @discount = Discount.new(percent: params[:percent], 
                               threshold: params[:threshold],
                               merchant_id: @merchant.id)
    if @discount.save 
      flash.notice = "Congrats on your New Bulk Discount!"
      redirect_to merchant_discounts_path(@merchant)
    else
      flash.notice = "That's Not Quite Right! Try Again, if you wish!"
      redirect_to new_merchant_discount_path(@merchant)
    end
  end

  def destroy
    @discount.destroy
    redirect_to merchant_discounts_path(@merchant)
  end

  private
  def discount_params
    params.require(:discount).permit(:percent, :threshold)
  end

  def find_discount_and_merchant
    @discount = Discount.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end