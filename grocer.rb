require 'pry'

def consolidate_cart(cart)
  # code here
  c_cart = {}
  cart.each do |element|
    element.each_pair do |key, value|
      if c_cart[key].nil?
        c_cart[key] = value
        c_cart[key][:count] = 1
      else
        c_cart[key][:count] = c_cart[key][:count] + 1
      end
    end
  end
  c_cart
end

def apply_coupons(cart, coupons)
  new_cart = {}
  new_cart = cart
  coupons.each do |key|
    item = key[:item]
    if cart[item] && cart[item][:count] >= key[:num]
        if new_cart["#{item} W/COUPON"]
          new_cart["#{item} W/COUPON"][:count] += 1
        else
          new_cart["#{item} W/COUPON"] = {:count => 1, :price => key[:cost]}
          new_cart["#{item} W/COUPON"][:clearance] = cart[item][:clearance]
        end
      cart[item][:count] -= key[:num]
    end
  end
  new_cart
end

def apply_clearance(cart)
  # code here
  cart.each do |key, value|
    if cart[key][:clearance] == true
      price = cart[key][:price]
      cart[key][:price] = price - (price * 0.2)
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
  new_cart = consolidate_cart(cart)
  couponed = apply_coupons(new_cart, coupons)
  discounted = apply_clearance(couponed)
  grand_total = 0.0
  discounted.each do |key, value|
    if discounted[key][:count] > 0
      i = 0
      until i == discounted[key][:count]
        grand_total += discounted[key][:price]
        i += 1
      end
    end
  end
  if grand_total > 100
    grand_total = grand_total * 0.9
  end
  #binding.pry
  grand_total
end


groceries = [{"BEETS" => {:price => 2.50, :clearance => false}}, {"BEETS" => {:price => 2.50, :clearance => false}}]
coupons = [{:item => "AVOCADO", :num => 2, :cost => 5.00},{:item => "CHEESE", :num => 3, :cost => 15.00}]

cart = consolidate_cart(groceries)

#puts apply_coupons(cart, coupons)
puts checkout(groceries, coupons)
