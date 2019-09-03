# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.create!(first_name: 'aaaaa', last_name: 'aaaaa', email: 'dfdd@yopmail.com', password: '123456')
  end

  describe 'creation' do
    it 'should have one user created after being created' do
      expect(User.all.count).to eql(1)
    end
  end

  describe 'validations' do
    it 'should not let a user be created without an email address' do
      @user.email = nil
      expect(@user).to_not be_valid
    end

    it 'should not let a user be created without an first name' do
      @user.first_name = nil
      expect(@user).to_not be_valid
    end

    it 'should not let a user be created without an last name' do
      @user.last_name = nil
      expect(@user).to_not be_valid
    end

    it 'should have length at least 6' do
      len = @user.password.length
      expect(len).to be >= 6
    end

    it 'cannot use the same email multiple times' do
      user1 = User.new
      user1.email = 'dfdd@yopmail.com'
      expect(user1).to_not be_valid
    end
  end

  describe 'associations' do
    it 'should have one cart' do
      should have_one(:cart)
    end

    it 'should has many products' do
      should have_many(:products)
    end

    it 'should has many orders' do
      should have_many(:orders)
    end

    it 'should has many addresses' do
      should have_many(:addresses)
    end
  end
end
