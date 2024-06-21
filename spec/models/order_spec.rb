require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'After creation' do
    before :each do
      @category = Category.create!( name: 'Trees' )
      @product1 = Product.create!( name: 'Arbutus', price_cents: 50, quantity: 10, category: @category )
      @product2 = Product.create!( name: 'Gary Oak', price_cents: 100, quantity: 5, category: @category )
      # Setup at least one product that will NOT be in the order
      @product3 = Product.create!( name: 'Silver Pine', price_cents: 25, quantity: 8, category: @category )
    end
    
    it 'deducts quantity from products based on their line item quantities' do
      # 1. initialize order with necessary fields (see orders_controllers, schema and model definition for what is required)
      @order = Order.new( email: 'test@email.com', total_cents: 750, stripe_charge_id: 'testcharge')
      # 2. build line items on @order
      @order.line_items.new(
        product: @product1,
        quantity: 7,
        item_price: @product1.price_cents,
        total_price: @product1.price_cents * 7
      )
      @order.line_items.new(
        product: @product2,
        quantity: 4,
        item_price: @product2.price_cents,
        total_price: @product2.price_cents * 4
      )
      # 3. save! the order - ie raise an exception if it fails (not expected)
      @order.save!
      expect(@order).to be_valid
      # 4. reload products to have their updated quantities
      @product1.reload
      @product2.reload
      # 5. use RSpec expect syntax to assert their new quantity values
      expect(@product1.quantity).to eq(3)
      expect(@product2.quantity).to eq(1)
    end
    
    it 'does not deduct quantity from products that are not in the order' do
      # 1. initialize order with necessary fields (see orders_controllers, schema and model definition for what is required)
      @order = Order.new( email: 'test2@email.com', total_cents: 350, stripe_charge_id: 'testcharge2')
      # 2. build line items on @order
      @order.line_items.new(
        product: @product1,
        quantity: 3,
        item_price: @product1.price_cents,
        total_price: @product1.price_cents * 7
      )
      @order.line_items.new(
        product: @product2,
        quantity: 2,
        item_price: @product2.price_cents,
        total_price: @product2.price_cents * 4
      )
      # 3. save! the order - ie raise an exception if it fails (not expected)
      @order.save!
      expect(@order).to be_valid
      # 4. reload products to have their updated quantities
      @product1.reload
      @product2.reload
      @product3.reload
      # 5. use RSpec expect syntax to assert their new quantity values
      expect(@product3.quantity).to eq(8)
    end
  end
end
