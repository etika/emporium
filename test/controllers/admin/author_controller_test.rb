require 'test_helper'

class Admin::AuthorControllerTest < ActionController::TestCase
  fixtures :authors
  test 'New page' do
   get :new
   assert_template 'admin/author/new'
   assert_tag 'h1',:content=>"Create new author"
   assert_tag 'form',:attributes=>{:action=>"/admin/author/create"}
  end
  test "should get new" do
    get :new
    assert_response :success
  end
  test 'failing create' do
    assert_no_difference(Author,:count) do
     post :create,:author=>{:first_name=>"Joel"}
     assert_response :success
     assert_template 'admin/author/new'
     assert_tag :tag=>'div',:attributes=>{:class=>'fieldWithErrors'}
    end
  end
  test "should get create" do
    # assert_equal 0, Author.all.size
    # post :create,author:{first_name:"Joel",last_name:'Spolsky'}
    # assert_response :redirect
    # assert_redirected_to :action=>"index"
    # assert_equal 1,Author.all.size
    # assert_equal 'Author Joel Spolsky was successfully created',flash[:notice]
    # get :create
    # assert_response :success
    get :new
    assert_template 'admin/author/new'
    assert_difference(Author,:count) do 
      post :create,:author=>{:first_name=>"Joel",:last_name=>"Spolsky"}
      assert_response :redirect
      assert_redirected_to :action=>'index'
    end
    assert_equal 'Author Joel Spolsky was successfully created',flash[:notice]
  end

  test "should get edit" do
    get :edit,:id=>1
    assert_tag :tag=>'input',:attributes=>{:name=>'author[first_name]',value: 'Joel'}
    assert_tag :tag=>'input',:attributes=>{:name=>'author[last_name]',value:'Spolsky'}
  end

  test "should get update" do
    post :update,:id=>1,:author=>{:first_name=>'Joseph',:last_name=>'Spolsky'}
    assert_response :redirect
    assert_redirected_to :action=> 'show',:id=>1
    assert_equal 'Joseph',Author.find(1).first_name
  end

  test "should get destroy" do
    assert_difference(Author,:count,-1)do
      post :destroy,:id=>1
      assert_response :redirect
      assert_redirected_to :action=>'index'
      follow_redirect
      assert_tag :tag=>'div',:attributes=>{:id=>'notice'},:content=>"Successfully deleted author Joel Spolsky" 
    end
  end

  test "should get show" do
    get :show,:id => 1
    assert_template 'admin/author/show'
    assert_equal 'Joel',:assigns["author"].first_name
    assert_equal 'Spolsky',:assign["author"].last_name
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_tag  :tag =>' table',:children=>{:count=>Author.count + 1,
                                    :only=>{:tag=>'tr'}}
    Author.al54l.each do |a|
      assert_tag :tag => 'td',:content =>  a.first_name
      assert_tag :tag => 'td',:content =>  a.last_name
    end
  end

end
