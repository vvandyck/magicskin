class Admin::OrdersController < ApplicationController
  require_role :admin
  layout "admin"

  def index
    @orders = Order.all
  end

  def cancel_order
    order = Order.find params[:order_id]
    order.status = Order::CANCELLED
    order.save
    index
    render :action => 'index'
  end

end
