require 'pry'

def consolidate_cart(cart)
  new_cart = {}
  cart.each do |item_hash|
    item_hash.each do |item_name, item_details|
      if new_cart[item_name] == nil
        new_cart[item_name] = item_details
        new_cart[item_name][:count] = 1
      else
        new_cart[item_name][:count] += 1
      end
    end
  end
  return new_cart
end

def apply_coupons(cart, coupons)
  if coupons == []
    return cart
  else
    coupon_items = []
    coupons.each do |coupon|
      cart.each do |item_name, item_details|
        if coupon[:item] == item_name && coupon[:num] <= item_details[:count]
          puts "coupon match on #{item_name}"
          item_details[:count] -= coupon[:num]
          coupon_item_details = {
            :price => coupon[:cost],
            :clearance => item_details[:clearance]
          }
          coupon_item_name = "#{item_name} W/COUPON"
          coupon_items.push({coupon_item_name => coupon_item_details})
          puts coupon_item_details
          cart
        end
      end
    end
  end
  coupon_cart = consolidate_cart(coupon_items)
  cart.merge!(coupon_cart)
  return cart
end

def apply_clearance(cart)
  cart.each do |item_name, item_details|
      # puts item_hash
      if item_details[:clearance] == true
        new_price =  item_details[:price] * 0.8
        item_details[:price] = new_price.round(2)
      end
    end
  end


def checkout(cart, coupons)
  total = 0.00
  new_cart = consolidate_cart(cart)
  new_cart = apply_coupons(new_cart, coupons)
  new_cart = apply_clearance(new_cart)
  new_cart.each do |item_name, item_details|
    total += item_details[:price] * item_details[:count]
  end
if total > 100
  total = total * 0.9
end
return total.round(2)
end
