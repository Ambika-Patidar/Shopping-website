class AddressesController < ApplicationController
  before_action :require_login, only:[:index , :new, :create]
  before_action :user_addresses, only:[:index, :destroy, :default_address]
  before_action :get_address, only:[:destroy, :default_address]

  def new
    @address = Address.new
  end

  def index
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
    if @address.destroy
      flash[:info] = "Successfully Address  Deleted "
      redirect_to addresses_path
    end
  end

  def default_address
    @addresses.each do |user_address|
      if user_address.id == @address.id
        user_address.default = true
        user_address.save
        flash[:info] = "Successfully Make Your Default Address"
        redirect_to addresses_path
      else
        user_address.default = false
        user_address.save
      end
    end
  end

  private

  def address_params
    params.require(:address).permit(:building_no, :area, :city, :state, :pincode)
  end

  def user_addresses
    @addresses = current_user.addresses
  end

  def get_address
    @address = @addresses.find_by(id: params[:id])
  end
end
