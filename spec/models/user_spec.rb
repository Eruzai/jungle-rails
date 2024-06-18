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
      it 'returns the error "Password confirmation doesn\'t match Password"' do
        @user = User.create( first_name: 'Johnny', last_name: 'Test', email: 'jtest@email.com', password: 'test1234', password_confirmation: 'test123')

        expect(@user).not_to be_valid
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end

    describe 'given no password' do
      it 'returns the error "Password can\'t be blank"' do
        @user = User.create( first_name: 'Johnny', last_name: 'Test', email: 'jtest@email.com', password: nil, password_confirmation: nil)

        expect(@user).not_to be_valid
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
    end

    describe 'given no email' do
      it 'returns the error "Email can\'t be blank"' do
        @user = User.create( first_name: 'Johnny', last_name: 'Test', email: nil, password: 'test1234', password_confirmation: 'test1234')

        expect(@user).not_to be_valid
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
    end

    describe 'given no first name' do
      it 'returns the error "First name can\'t be blank"' do
        @user = User.create( first_name: nil, last_name: 'Test', email: 'jtest@email.com', password: 'test1234', password_confirmation: 'test1234')

        expect(@user).not_to be_valid
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
    end

    describe 'given no last name' do
      it 'returns the error "Last name can\'t be blank"' do
        @user = User.create( first_name: 'Johnny', last_name: nil, email: 'jtest@email.com', password: 'test1234', password_confirmation: 'test1234')

        expect(@user).not_to be_valid
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
    end

    describe 'given an email that exists in the database regardless of case' do
      it 'returns the error "Email has already been taken"' do
        @user = User.create( first_name: 'Johnny', last_name: 'Test', email: 'jtest@email.com', password: 'test1234', password_confirmation: 'test1234')
        @user2 = User.create( first_name: 'Jack', last_name: 'Test', email: 'JTest@email.com', password: 'test1234', password_confirmation: 'test1234')

        expect(@user).to be_valid
        expect(@user2).not_to be_valid
        expect(@user2.errors.full_messages).to include("Email has already been taken")
      end
    end

    describe 'given a password that is too short' do
      it 'returns the error "Password is too short (minimum is 8 characters)"' do
        @user = User.create( first_name: 'Johnny', last_name: 'Test', email: 'jtest@email.com', password: 'test123', password_confirmation: 'test123')

        expect(@user).not_to be_valid
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
      end
    end

  end

  describe '.authenticate_with_credentials' do

    before do
      @user = User.create( first_name: 'Just', last_name: 'Aguy', email: 'jaguy@email.com', password: 'testtest', password_confirmation: 'testtest')
    end

    describe 'when given correct login credentials' do
      it 'logs in successfully' do
        @session = User.authenticate_with_credentials('jaguy@email.com', 'testtest')

        expect(@session).to eq(@user)
      end
    end

    describe 'when given an email that does not exist' do
      it 'does not log in' do
        @session = User.authenticate_with_credentials('jagirl@email.com', 'testtest')

        expect(@session).to eq(nil)
      end
    end

    describe 'when given an incorrect password' do
      it 'does not log in' do
        @session = User.authenticate_with_credentials('jaguy@email.com', 'testtest1')

        expect(@session).to eq(nil)
      end
    end

    describe 'when given correct login credentials with an email that has spaces in front or behind' do
      it 'logs in successfully' do
        @session = User.authenticate_with_credentials('  jaguy@email.com  ', 'testtest')

        expect(@session).to eq(@user)
      end
    end

    describe 'when given correct login credentials with an email that is in a different case' do
      it 'logs in successfully' do
        @session = User.authenticate_with_credentials('JAguy@EMAIL.com', 'testtest')

        expect(@session).to eq(@user)
      end
    end

  end

end
