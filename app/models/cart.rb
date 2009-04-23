class Cart
  attr_reader :items

  def initialize
    @items = []
  end

  #
  # Add an item to the cart.
  # Should be called add_item
  #
  def add_item(item)
    current_item = find_current_item(item)
    if current_item
      current_item.increment_quantity
    else
      @items << CartItem.new(item)
    end
    current_item
  end

  def remove_item(item)
    current_item = find_current_item(item)
    if current_item.quantity>0
      current_item.decrement_quantity
    end
    if current_item.quantity == 0
      @items.delete current_item
    end
  end

  def total_price
    @items.sum { |item| item.price }
  end

  def total_items
    @items.sum {|item| item.quantity }
  end

  private
  def find_current_item(item)
      @items.find {|j| j.item == item}
  end

end
