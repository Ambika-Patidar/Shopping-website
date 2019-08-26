class AddressesController < ApplicationController
  before_action :require_login, only:[:index , :new, :create]

  def new
    @address = Address.new
  end

  def index
    @addresses = current_user.addresses
  end

  def create
    @address = current_user.addresses.build(address_params)
    if @address.save
      redirect_to order_items_path
    else 
      render 'new'
    end
  end

  private

  def address_params
    params.require(:address).permit(:building_no, :area, :city, :state, :pincode)
  end
end
