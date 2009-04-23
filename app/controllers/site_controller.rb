class SiteController < ApplicationController
  before_filter :find_cart, :except => :empty_cart

  def index
    @skins = Skin.public_skins
  end

  # show the user's page.
  def users
    @user = User.find_by_login params[:user_name]
    if @user==nil then redirect_to_index('invalid user');end
    # show all the users public skins
    @skins = Skin.find_all_by_user_id @user, :conditions => 'public =1'
  end

  def add_to_cart
    begin
      item = Skin.find(params[:id])
      logger.info "*******item=#{item.to_s}"
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid item #{params[:id]}" )
      redirect_to_index("Invalid item")

    else
      @current_item = @cart.add_item(item)
      redirect_to_index unless request.xhr?
    end
  end

  def remove_item
    item = Skin.find(params[:id])
    @cart.remove_item(item)
    redirect_to_index unless request.xhr?
  end

  def empty_cart
    clear_cart
    redirect_to_index
  end

  def checkout
    if @cart.items.empty?
      redirect_to_index("Your cart is empty" )
    else
      @order = Order.new
      @address = Address.new
      @user = User.new
    end
  end

  def save_order
    @order = Order.new(params[:order])
    @order.add_line_items_from_cart(@cart)
    @order.status  = Order::NEW
    @address = Address.new(params[:address])
    @user = User.new(params[:user])
    @user.email = @order.email
    @user.save
 
    Order.transaction do
      @address.save!
      @order.address = @address
      @order.save!
      email = OrderMailer.create_confirm(@order)
    #  OrderMailer.deliver(email)
      clear_cart
      # check payment type.
      # and forward as apropriate
      redirect_to_index("Thank you for your order" )
    end

  #rescue
  #  logger.error("foo Could not save order #{@order}." )
  #  @address.valid?
  #  @order.valid?
  #  render :action => :checkout

  end

  private

  def clear_cart
    session["cart"] = nil
  end

  def find_cart
    @cart = (session["cart"] ||= Cart.new)
  end

  def redirect_to_index(msg = nil)
    flash[:notice] = msg if msg
    redirect_to :action => :index
  end
  
end
