class Order < ApplicationRecord
  
  has_many :line_items

  monetize :total_cents, numericality: true

  validates :stripe_charge_id, presence: true

  after_create :deduct_order_quantities_from_stock

  private

  def deduct_order_quantities_from_stock
    self.line_items.each do |item|
      @product = Product.find(item.product.id)
      @product.quantity = @product.quantity - item.quantity
      @product.save
    end
  end

end
