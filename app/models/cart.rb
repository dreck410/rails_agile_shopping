class Cart < ActiveRecord::Base
	has_many :line_items, dependent: :destroy


	def add_product(product_id)
		current_item = line_items.find_by(product_id: product_id)

		if current_item
			current_item.quantity += 1
		else
			current_item = line_items.build(product_id: product_id, quantity: 1)
		end
		return current_item
	end

	def remove_product(line_item)
		if line_item.quantity == 1
			line_item.destroy
		elsif line_item.quantity > 1
			line_item.quantity -= 1
		end
		#binding.pry
	end

	def total_price
		total = 0
		line_items.each do |item|
			total += item.total_price
		end
		total
	end

end
