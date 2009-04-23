require 'test_helper'

class SkinsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:skins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create skin" do
    assert_difference('Skin.count') do
      post :create, :skin => { }
    end

    assert_redirected_to skin_path(assigns(:skin))
  end

  test "should show skin" do
    get :show, :id => skins(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => skins(:one).id
    assert_response :success
  end

  test "should update skin" do
    put :update, :id => skins(:one).id, :skin => { }
    assert_redirected_to skin_path(assigns(:skin))
  end

  test "should destroy skin" do
    assert_difference('Skin.count', -1) do
      delete :destroy, :id => skins(:one).id
    end

    assert_redirected_to skins_path
  end
end
