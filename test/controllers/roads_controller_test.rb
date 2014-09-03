require 'test_helper'

class RoadsControllerTest < ActionController::TestCase
  setup do
    @road = roads(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:roads)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create road" do
    assert_difference('Road.count') do
      post :create, road: { length: @road.length }
    end

    assert_redirected_to road_path(assigns(:road))
  end

  test "should show road" do
    get :show, id: @road
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @road
    assert_response :success
  end

  test "should update road" do
    patch :update, id: @road, road: { length: @road.length }
    assert_redirected_to road_path(assigns(:road))
  end

  test "should destroy road" do
    assert_difference('Road.count', -1) do
      delete :destroy, id: @road
    end

    assert_redirected_to roads_path
  end
end
