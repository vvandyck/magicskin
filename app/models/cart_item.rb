class CartItem

  attr_reader :item, :quantity

  def initialize(item)
    @item = item
    @quantity = 1
  end

  def increment_quantity
    @quantity += 1
  end

  def decrement_quantity
    @quantity -=1
  end

   def name
    @item.name
  end

  def unit_price
    @item.price
  end

  def unit_postage
    #@item.postage
    # standard postage
    1
  end

  def price
    unit_price * @quantity
  end

  def price_with_postage
    (unit_price * @quantity) + (unit_postage * @quantity)
  end
end
