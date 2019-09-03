# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  before(:each) do
    @user = User.create!(email: 'dfdd@yopmail.com', password: '123456')
    @category = Category.create!(category_name: 'Electronics')
    @product = Product.create!(name: 'TV', brand: 'Mi', price: '10000',
                               user_id: @user.id, category_id: @category.id)
  end

  describe 'creation' do
    it 'should have one product created after being created' do
      expect(Product.all.count).to eql(1)
    end
  end

  describe 'validations' do
    it 'should not let a product be created without an name' do
      @product.name = nil
      expect(@product).to_not be_valid
    end

    it 'should not let a product be created without an brand' do
      @product.brand = nil
      expect(@product).to_not be_valid
    end

    it 'should not let a product be created without an price' do
      @product.price = nil
      expect(@product).to_not be_valid
    end
  end

  describe 'associations' do
    it 'should belongs to category' do
      should belong_to(:category)
    end

    it 'should belongs to  user' do
      should belong_to(:user)
    end

    it 'should has many cart items' do
      should have_many(:cart_items).dependent(:destroy)
    end

    it 'should has many cart through cart items' do
      should have_many(:carts).through(:cart_items)
    end

    it 'should has many order items' do
      should have_many(:order_items)
    end

    it 'should has many orders through order items' do
      should have_many(:orders).through(:order_items)
    end
  end
end
