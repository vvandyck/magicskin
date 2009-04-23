class Order < ActiveRecord::Base
  has_many :line_items
  belongs_to :address

  PAYMENT_TYPES = [
    # Displayed          stored in db
    [ "Bank transfer" ,    "transfer" ]#, [ "Google checkout" ,  "google"   ]
  ]

  NEW         = 0
  PAID        = 1
  DELIVERED   = 2
  CANCELLED   = 3

  ORDER_STATUS = [
    ["New",         NEW],
    ["Paid",        PAID],
    ["Delivered",   DELIVERED],
    ["Cancelled",   CANCELLED]
  ]

  validates_presence_of  :email, :pay_type, :status
  validates_inclusion_of :pay_type, :in => PAYMENT_TYPES.map {|disp, value| value}
  validates_inclusion_of :status, :in => ORDER_STATUS.map {|disp, value| value}

  validates_format_of :email,
    :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
    :message => 'email must be valid'

  def total_price
    line_items.collect {|item|item.total_price}.sum
  end

  def add_line_items_from_cart(cart)
    cart.items.each do |item|
      li = LineItem.from_cart_item(item)
      line_items << li
    end
  end
end
