require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Validations' do
    
    describe 'given all valid parameters' do
      it 'saves the product to the database' do
        @category = Category.create( name: 'Trees' )
        @product = Product.create( name: 'Arbutus', price_cents: 52500, quantity: 10, category: @category )

        expect(@product).to be_valid
        expect(@product.save).to be true
      end
    end

    describe 'given nil name' do
      it 'does not save the product to the database' do
        @category = Category.create( name: 'Trees' )
        @product = Product.create( name: nil, price_cents: 52500, quantity: 10, category: @category )

        expect(@product).not_to be_valid
        expect(@product.errors.full_messages).to include("Name can't be blank")
      end
    end

    describe 'given nil price' do
      it 'does not save the product to the database' do
        @category = Category.create( name: 'Trees' )
        @product = Product.create( name: 'Arbutus', price_cents: nil, quantity: 10, category: @category )

        expect(@product).not_to be_valid
        expect(@product.errors.full_messages).to include("Price cents can't be blank")
      end
    end

    describe 'given nil quantity' do
      it 'does not save the product to the database' do
        @category = Category.create( name: 'Trees' )
        @product = Product.create( name: 'Arbutus', price_cents: 52500, quantity: nil, category: @category )

        expect(@product).not_to be_valid
        expect(@product.errors.full_messages).to include("Quantity can't be blank")
      end
    end

    describe 'given nil category' do
      it 'does not save the product to the database' do
        @category = Category.create( name: 'Trees' )
        @product = Product.create( name: 'Arbutus', price_cents: 52500, quantity: 10, category: nil )

        expect(@product).not_to be_valid
        expect(@product.errors.full_messages).to include("Category can't be blank")
      end
    end

  end

end
