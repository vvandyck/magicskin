class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :skin

   def self.from_cart_item(cart_item)     
    li = self.new
    li.skin            = cart_item.item
    li.name            = cart_item.name
    li.quantity        = cart_item.quantity
    li.unit_price      = cart_item.unit_price
    li.unit_postage    = cart_item.unit_postage
    li.total_price     = cart_item.price_with_postage
    li
  end
end
