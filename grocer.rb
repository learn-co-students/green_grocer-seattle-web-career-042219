require 'pry'

def consolidate_cart(cart)
  # code here
  
  new_hash = {}
  array = []
  
  # creates a new hash with unique item names as keys to empty hash
  # populates an array with all items to eventually count similar items
  
  cart.each do |item_data|
    item_data.each do |item, info|
      array.push(item)
      new_hash[item] = {}
    end
  end
  
  # updates item key with values one at a time
  # updates item key with count

  cart.each do |item_data|
    item_data.each do |item, info|
      info.each do |key, values|
        new_hash[item][key] = values
      end
      new_hash[item][:count] = array.count(item)
    end
  end
  new_hash
end

def apply_coupons(cart, coupons)
  # code here
  new_hash = {}
  
  cart.each do |item, info|
    if coupons.length > 0
      coupons.each do |coupon|
        if coupon[:item] == item  #if coupon item is in cart
          if info[:count] >= coupon[:num] #if coupon amount is valid for cart
        
            count = info[:count] / coupon[:num] #precalculate count for coupon
            remainder = info[:count] % coupon[:num] #precalculate for item
          
            new_hash[item] = info #recreate non non-discounted item in new hash
          
            new_hash[item][:count] = remainder #include remaining non-discounted
          
            new_hash["#{item} W/COUPON"] = {:price => coupon[:cost], :clearance => info[:clearance], :count => count} #create coupon item info
          else
            new_hash[item] = info
          end
        else
          new_hash[item] = info
        end
      end
    else
      new_hash[item] = info
    end
  end
  new_hash
end


def apply_clearance(cart)
  # code here
  
  cart.each do |item, info|
    if info[:clearance] == true
      info[:price] = (info[:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
  
  total = 0
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  
  
  
  cart.each do |item, info|
    total += info[:price]*info[:count]
  end
  
  if total > 100
    total = (total*0.9).round(2)
  end
  total
end
