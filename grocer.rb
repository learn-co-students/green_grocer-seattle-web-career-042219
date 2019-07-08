=begin
[{"TEMPEH"=>{:price=>3.0, :clearance=>true}},
 {"PEANUTBUTTER"=>{:price=>3.0, :clearance=>true}},
 {"ALMONDS"=>{:price=>9.0, :clearance=>false}}]
=end

require 'pry'
def consolidate_cart(cart)
  # code here
  min_cart = {}
  cart.each do |item|
  	item.each do |name, atts|
  		if min_cart[name]
  			item[name][:count] += 1
  			min_cart[name] = atts
  		else
  			item[name][:count] = 1
  			min_cart[name] = atts
  		end
  	end
  end
  min_cart
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |coupon|
  	name = coupon[:item]
  	if cart[name] && cart[name][:count] >= coupon[:num]
  		sub_coupon = cart[name][:count] -= coupon[:num]
  		if cart["#{name} W/COUPON"]
  			sub_coupon
        	cart["#{name} W/COUPON"][:count] += 1
  		else
  			sub_coupon
        	cart["#{name} W/COUPON"] = {:count => 1, :price => coupon[:cost]}
        	cart["#{name} W/COUPON"][:clearance] = cart[name][:clearance]
        end
    end
  end
  cart
end

def apply_clearance(cart)
  # code here
  cart.each do |name, atts|
  	if atts[:clearance]
  		atts[:price] = (atts[:price] * 0.8).round(2)
  	end
  end
  cart
end

def checkout(cart, coupons)
  # code here
  min_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(min_cart, coupons)
  final_cart = apply_clearance(coupon_cart)
  total = 0
  final_cart.each do |name, atts|
  	total += atts[:price] * atts[:count]
  end
  if total > 100
  	total = (total * 0.9).round(2)
  end
  total
end
