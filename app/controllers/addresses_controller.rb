# frozen_string_literal: true

# This Class Store and Delete and set default Address of particular User.
class AddressesController < ApplicationController
  before_action :require_login, only: %i[index new create]
  before_action :user_addresses, only: %i[index destroy set_address]
  before_action :find_address, only: %i[destroy set_address]

  def new
    @address = current_user.addresses.new
  end

  def index
    flash[:info] = 'Choose Default Address For Deliver Your Order'
  end

  def create
    @address = current_user.addresses.new(address_params)
    if @address.save
      flash[:info] = 'Successfully Added delivery address'
      redirect_to addresses_path
    else
      render 'new'
    end
  end

  def destroy
    address_destory = @address.destroy
    if address_destory
      flash[:info] = 'Successfully Address  Deleted '
      redirect_to addresses_path
    else
      flash[:danger] = 'Address not Deleted'
    end
  end

  def set_address
    @addresses.update_all(default: false)
    @address.update(default: true)
    flash[:info] = 'Successfully Set Your Address'
    redirect_to addresses_path
  end

  private

  def address_params
    params.require(:address).permit(:building_no, :area,
                                    :city, :state, :pincode)
  end

  def user_addresses
    @addresses = current_user.addresses
  end

  def find_address
    @address = @addresses.find_by_id(params[:id])
  end
end
