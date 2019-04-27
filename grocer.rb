require "pry"
def consolidate_cart(cart)
  cart.each_with_object({}) do |item, result_hash|
    item.each do |item_key, item_value|
      # binding.pry
      if result_hash[item_key]
        item_value[:count] +=1
      else
        item_value[:count] =1
        result_hash[item_key] = item_value
      end
    end
  end
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    coupon_item=coupon[:item]
    if cart[coupon_item] && cart[coupon_item][:count] >= coupon[:num]
      if cart["#{coupon_item} W/COUPON"]
        cart["#{coupon_item} W/COUPON"][:count]+=1
      else
        cart["#{coupon_item} W/COUPON"] = {:count => 1, :price => coupon[:cost]}
        cart["#{coupon_item} W/COUPON"][:clearance] = cart[coupon_item][:clearance]
      end
      cart[coupon_item][:count] -= coupon[:num]    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |cart_item, properties_of_cart_item|
    if properties_of_cart_item[:clearance]
      updated_price = properties_of_cart_item[:price] *0.80
      properties_of_cart_item[:price] = updated_price.round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(couponed_cart)
  total = 0
  final_cart.each do |name, properties|
    total += properties[:price]*properties[:count]
  end
  total = total *0.90 if total > 100
  total
end
