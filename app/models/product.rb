class Product < ActiveRecord::Base
  validates :title, :description, :image_url, :price, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true,
   format: {
  		with: /.*\.(png|jpg|jpeg|bmp|gif)\z/i,
  		message: 'Must be a gif, png, jpg, jpeg, or bmp image.'
  }

  def self.latest
  	Product.order(:updated_at).last
  end
  
end
