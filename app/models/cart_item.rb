class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item

  def tax_price
    (self.item.price * 1.1).floor
  end

  def subtotal
    self.tax_price * self.amount
  end
end
