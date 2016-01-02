require 'json'
path = File.join(File.dirname(__FILE__), '../data/products.json')
file = File.read(path)
products_hash = JSON.parse(file)

def price_discount purchases,full_price
  discounts = []
  selling_price = []
  purchases.each do |purchase|
    selling_price << purchase["price"]
    if full_price.to_f > purchase["price"]
      discounts << full_price.to_f - purchase["price"]
    end
  end
  return discounts,selling_price
end

def average_discount(discounts, item)
  total_discount = 0
  if discounts.size > 0
    discounts.each do |discount|
      total_discount += discount
    end
  end
  total_discount
end

def total_price(prices)
  total_price = 0
  prices.each { |price| total_price += price }
  total_price
end

def total_revenue(revenues)
  total_revenue = 0
  revenues.each { |revenue| total_revenue += revenue }
  total_revenue
end
def revenue_quantity_price items,brand
  revenues = []
  brand_toys = 0
  prices = []
  items.each do |item|
    if item["brand"] == brand
      brand_toys += item["stock"]
      prices << item["full-price"].to_f.round(2)
      item["purchases"].each do |purchase|
        revenues << (purchase["price"]).to_f
      end
    end
  end
  return revenues,brand_toys,prices
end

def find_brand(products_hash)
  brands = []
  products_hash["items"].each do |item|
    brands << item["brand"]
  end
  brands
end
def discount_percentage average_discount,full_price
  ((average_discount/full_price)*100).round(2)
end


# Print today's date
puts Time.now.strftime("%m/%d/%Y")

puts "                     _            _       "
puts "                    | |          | |      "
puts " _ __  _ __ ___   __| |_   _  ___| |_ ___ "
puts "| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|"
puts "| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\"
puts "| .__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/"
puts "| |                                       "
puts "|_|                                       "



# For each product in the data set:
  # Print the name of the toy
  # Print the retail price of the toy
  # Print the name of the brand
  # Calculate and print the total number of purchases
  # Calcalate and print the total amount of sales
  # Calculate and print the average price the toy sold for
  # Calculate and print the average discount based off the average sales price

  products_hash["items"].each do |item|
    # Print the name of the toy
    puts item["title"]
    # Print the retail price of the toy
    puts item["full-price"]
    # Print the name of the brand
    puts item["brand"]
    # Calculate and print the total number of purchases
    puts item["purchases"].size
    discounts,selling_price = price_discount item["purchases"],item["full-price"]
    puts "Total Amount of Sales for #{item["title"]}"
    total_selling_price = 0
    selling_price.each { |price| total_selling_price+=price }
    puts total_selling_price
    # Calculate and print the average price the toy sold for
    puts "Average Selling Price:"
    puts (total_selling_price/selling_price.size)
    total_discount = average_discount(discounts, item)
    #Calculate and print the average discount based off the average sales price
    puts "Average Discounted Percentage:"
    puts discount_percentage((total_discount/discounts.size).round(2),item["full-price"].to_f).to_s + " %"
    puts "---------------------------------------"
  end

  puts " _                         _     "
	puts "| |                       | |    "
	puts "| |__  _ __ __ _ _ __   __| |___ "
	puts "| '_ \\| '__/ _` | '_ \\ / _` / __|"
	puts "| |_) | | | (_| | | | | (_| \\__ \\"
	puts "|_.__/|_|  \\__,_|_| |_|\\__,_|___/"
	puts

# For each brand in the data set:
  # Print the name of the brand
  # Count and print the number of the brand's toys we stock
  # Calculate and print the average price of the brand's toys
  # Calculate and print the total revenue of all the brand's toy sales combined


  brands = find_brand(products_hash)

  brands.uniq!.each do |brand|
      # Print the name of the brand
      puts brand
      revenues,stock,prices = revenue_quantity_price(products_hash["items"],brand)
      # Count and print the number of the brand's toys we stock
      puts "Stock for #{brand}:"
      puts stock
      total_price = total_price(prices)
      #Calculate and print the average price of the brand's toys
      puts "Average price for #{brand}"
      puts (total_price/prices.size).round(2)
      total_revenue = total_revenue(revenues)
      #Calculate and print the total revenue of all the brand's toy sales combined
      puts "Total revenue for #{brand}"
      puts total_revenue.round(2)
      puts "---------------------------------------"
  end







