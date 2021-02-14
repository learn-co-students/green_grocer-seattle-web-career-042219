require 'pry'
def consolidate_cart(cart)
  # code here
  new_hash = {}
  cart.each do |food_hash|
    food_count = cart.count(food_hash)
    food_hash.each do |food, attributes|
      attributes[:count] = food_count
      new_hash[food] = attributes
    end
  end
  new_hash
end

def apply_coupons(cart, coupons)
  # code here
  case_type = nil
  coupons_applied = true
  coupon_food_array = coupons.map do |coupon_hash|
    coupon_hash[:item]
  end

  coupon_items_in_cart = coupon_food_array.map do |coupon_food|
    if cart.keys.include?(coupon_food)
      coupon_food
    end
  end.flatten.compact

  #if cart.keys.include?("CHEESE") && cart.keys.include?("AVOCADO")
  #  binding.pry
  #end

  if coupon_items_in_cart.empty? == true
    coupons_applied = false
    cart = cart
  else
    coupons_applied =true
  end

if coupons_applied == true
    coupon_items_in_cart.map do |food|
    correct_coupon_hash = coupons.map do |coupon_hash|
      if coupon_hash[:item] == food
        coupon_hash
      end
    end.flatten.compact
    coupon_coverage = cart[food][:count] - correct_coupon_hash.first[:num]
    #if coupon_food_array == ["AVOCADO", "AVOCADO"]
    #  binding.pry
    #end

      case
      when coupon_coverage == 0
        case_type = "base_case"
      when coupon_coverage > 0
        case_type = "more_items_than_coupon"
      when coupon_coverage < 0
        case_type = "less_items_than_coupon"
      end

      if case_type == "base_case"
        cart["#{food} W/COUPON"] = {}
        cart["#{food} W/COUPON"][:price] = correct_coupon_hash.first[:cost]
        cart["#{food} W/COUPON"][:count] = 1
        cart["#{food} W/COUPON"][:clearance] = cart[food][:clearance]
        cart[food][:count] = coupon_coverage
      elsif case_type == "more_items_than_coupon"
        cart["#{food} W/COUPON"] = {}
        cart["#{food} W/COUPON"][:price] = correct_coupon_hash.first[:cost]
        cart["#{food} W/COUPON"][:count] = coupon_items_in_cart.count(food)
        cart["#{food} W/COUPON"][:clearance] = cart[food][:clearance]
        cart[food][:count] = coupon_coverage
      #elsif case_type == "coupon_not_appplicable"

      elsif  case_type == "less_items_than_coupon"
        #binding.pry
        cart["#{food} W/COUPON"] = {}
        cart["#{food} W/COUPON"][:price] = correct_coupon_hash.first[:cost]
        cart["#{food} W/COUPON"][:count] = coupon_items_in_cart.count(food) + coupon_coverage
        cart["#{food} W/COUPON"][:clearance] = cart[food][:clearance]
        cart[food][:count] = cart[food][:count]

      else

        cart = cart
      end
    end
end
cart
end

def apply_clearance(cart)
  # code here
  cart.each do |food, food_attributes|
      if food_attributes[:clearance] == true
        food_attributes[:price] = (food_attributes[:price] * 0.8).round(2)
      end
      cart[food] = food_attributes
    end
    cart

end

def checkout(cart, coupons)
  # code here
  clearance_flag = false
  coupons_flag = false
  case_type = nil
  total_price = 0
  if coupons.empty? == false
    coupons_flag = true
  end

  cart.each do |food_hash|
    food_hash.each do |food, attributes|
      if attributes[:clearance] == true
        clearance_flag = true
      end
    end
  end

  case
  when clearance_flag == false && coupons_flag == false
    case_type = "base case"
  when clearance_flag == false && coupons_flag == true
    case_type = "coupons only"
  when clearance_flag == true && coupons_flag == true
    case_type = "coupons and clearance"
  when clearance_flag == true && coupons_flag == true
    case_type = "clearance only"
  end


  if case_type == "base case"
    cart = consolidate_cart(cart)
    cart = apply_coupons(cart, coupons)
    cart = apply_clearance(cart)
    cart.each do |food, attributes|
        total_price = total_price + (attributes[:price]*attributes[:count]).round(2)
      end

  elsif case_type == "coupons only" || case_type == "coupons and clearance" || case_type = "clearance only"
    cart = consolidate_cart(cart)
    cart = apply_coupons(cart, coupons)
    cart = apply_clearance(cart)
    cart.each do |food, attributes|
        total_price = total_price + (attributes[:price]*attributes[:count]).round(2)
      end
  end
  if total_price > 100
    total_price = (total_price*0.9).round(2)
  end
    total_price
  end
