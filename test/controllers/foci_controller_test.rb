require 'test_helper'

class FociControllerTest < ActionController::TestCase
  setup do
    @focus = foci(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:foci)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create focus" do
    assert_difference('Focus.count') do
      post :create, focus: { context_id: @focus.context_id, snomedct_id: @focus.snomedct_id }
    end

    assert_redirected_to focus_path(assigns(:focus))
  end

  test "should show focus" do
    get :show, id: @focus
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @focus
    assert_response :success
  end

  test "should update focus" do
    patch :update, id: @focus, focus: { context_id: @focus.context_id, snomedct_id: @focus.snomedct_id }
    assert_redirected_to focus_path(assigns(:focus))
  end

  test "should destroy focus" do
    assert_difference('Focus.count', -1) do
      delete :destroy, id: @focus
    end

    assert_redirected_to foci_path
  end
end
