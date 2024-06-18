require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations: When creating a new user' do

    describe 'given all valid parameters' do
      it 'saves a new user to the database' do
        @user = User.create( first_name: 'Johnny', last_name: 'Test', email: 'jtest@email.com', password: 'test1234', password_confirmation: 'test1234')

        expect(@user).to be_valid
        expect(@user.save).to be true
      end
    end

    describe 'given password confirmation and password that do not match' do
      it 'does not save the user to the database' do
        @user = User.create( first_name: 'Johnny', last_name: 'Test', email: 'jtest@email.com', password: 'test1234', password_confirmation: 'test123')

        expect(@user).not_to be_valid
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end

    describe 'given no password' do
      it 'does not save the user to the database' do
        @user = User.create( first_name: 'Johnny', last_name: 'Test', email: 'jtest@email.com', password: nil, password_confirmation: nil)

        expect(@user).not_to be_valid
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
    end

    describe 'given no email' do
      it 'does not save the user to the database' do
        @user = User.create( first_name: 'Johnny', last_name: 'Test', email: nil, password: 'test1234', password_confirmation: 'test1234')

        expect(@user).not_to be_valid
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
    end

    describe 'given no first name' do
      it 'does not save the user to the database' do
        @user = User.create( first_name: nil, last_name: 'Test', email: 'jtest@email.com', password: 'test1234', password_confirmation: 'test1234')

        expect(@user).not_to be_valid
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
    end

    describe 'given no last name' do
      it 'does not save the user to the database' do
        @user = User.create( first_name: 'Johnny', last_name: nil, email: 'jtest@email.com', password: 'test1234', password_confirmation: 'test1234')

        expect(@user).not_to be_valid
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
    end

    describe 'given an email that exists in the database regardless of case' do
      it 'does not save the user to the database' do
        @user = User.create( first_name: 'Johnny', last_name: 'Test', email: 'jtest@email.com', password: 'test1234', password_confirmation: 'test1234')
        @user2 = User.create( first_name: 'Jack', last_name: 'Test', email: 'JTest@email.com', password: 'test1234', password_confirmation: 'test1234')

        expect(@user).to be_valid
        expect(@user2).not_to be_valid
        expect(@user2.errors.full_messages).to include("Email has already been taken")
      end
    end

  end

end
