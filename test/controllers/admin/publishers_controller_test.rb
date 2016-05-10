require 'test_helper'

class Admin::PublishersControllerTest < ActionController::TestCase
  setup do
    @publisher = publishers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:publishers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create publisher" do
    num_publishers=Publisher.count
    assert_difference('Publisher.count') do
      post :create, publisher: { name: @publisher.name }
    end
    assert_response :redirect
    assert_redirected_to admin_publisher_path(assigns(:publisher))
    assert_equal num_publishers + 1,Publisher.count
  end

  test "should show publisher" do
    get :show, id: @publisher
    assert_response :success
    assert_template 'show'
    assert_not_nil assigns["publisher"]
    assert assigns["publisher"].valid?
    assert_tag "h1",:content=>Publisher.find(1).name
  end

  test "should get edit" do
    get :edit, id: @publisher
    assert_response :success
  end

  test "should update publisher" do
    patch :update, id: @publisher, publisher: { name: @publisher.name }
    assert_response :redirect
    assert_redirected_to admin_publisher_path(assigns(:publisher))
    assert_equal 'Apress.com',Publisher.find(1).name
  end

  test "should destroy publisher" do
    assert_difference('Publisher.count', -1) do
      delete :destroy, id: @publisher
    end

    assert_redirected_to admin_publishers_path
  end
end
