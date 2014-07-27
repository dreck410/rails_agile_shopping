require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  fixtures :products

  test "product attributes must not be empty" do
  	product = Product.new
  	assert product.invalid?
  	assert product.errors[:title].any?
  	assert product.errors[:description].any?
  	assert product.errors[:image_url].any?
  	assert product.errors[:price].any?
  end

  test "titles must not repeat" do
  	product = Product.new(
  		title: products(:cat_food).title,
  		description: "ZZZ",
  		image_url:   "thing.png",
  		price:       8.99)
  	assert product.invalid?, "#{product.title} should already be taken"

  end
  test "price must not be negative" do
  	product = Product.new(
  		title: "Lorem",
  		description: "description",
  		image_url: "pic.png")
  	
  	product.price = -1
  	assert product.invalid?
  	assert_equal ["must be greater than or equal to 0.01"],
  		product.errors[:price]

  	product.price = 0
  	assert product.invalid?
  	assert_equal ["must be greater than or equal to 0.01"],
  		product.errors[:price]

  	product.price = 0.01
  	assert product.valid?
  end

  def new_product_where_image_is(image_url)
  	Product.new(
  		title:       "Title",
  		description: "description",
  		price:       5,
  		image_url:   image_url
  		)
  end

  test "images only accept jpg, png, bmp, jpeg" do
  	allowed = %w{fred.gif fred.png fred.PNG fred.GIF fred.bmp fred.BMp fre.jpg fr.jpeg www.google.com/stuff.png}
  	blocked = %w{fred.png.morestuff bad things.gif/more hello.doc}
  	
  	allowed.each do |good|
  		assert new_product_where_image_is(good).valid?, "#{good} should be valid"
  	end

  	blocked.each do |bad|
  		assert new_product_where_image_is(bad).invalid? , "#{bad} should be invalid"
  	end

  end

end
