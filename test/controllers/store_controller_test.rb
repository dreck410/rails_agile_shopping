require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should have 4 options on the side" do
  	get :index
  	assert_select '#columns #side a',minimum: 4
  end

  test "There are three items" do 
  	get :index
  	assert_select '#main .entry', 3
  end
  test "Programming Ruby appeared" do 
  	get :index
  	assert_select 'h3', 'Programming Ruby 1.9'
  end

  test "should format prices" do
  	get :index
  	assert_select '.price', /\$\d[,\d]*\.\d\d/
  end

end
