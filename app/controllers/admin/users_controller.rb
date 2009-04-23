class Admin::UsersController < ApplicationController
  require_role :admin
  layout "admin"

  def index
    @users = User.all
  end

  def skins
    @skins = Skin.find_all_by_user_id params[:user_id]
    render :partial => '/site/skins', :object => @skins
  end

end
