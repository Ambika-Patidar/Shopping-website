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
      flash[:info] = "Successfully Added delivery address"
      redirect_to order_items_path
    else 
      render 'new'
    end
  end

  def destroy
    @addresses = current_user.addresses
    address = @addresses.find_by(id: params[:id])
    byebug
    if address.destroy
      flash[:info] = "Successfully Address  Deleted "
      redirect_to addresses_path
    end
  end

  private

  def address_params
    params.require(:address).permit(:building_no, :area, :city, :state, :pincode)
  end
end
