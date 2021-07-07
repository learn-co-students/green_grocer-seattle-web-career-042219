def consolidate_cart(cart)
  # code here
  consolidated_hash = {}
  count = 0
  cart.each do |items|
    items.each do |name, detail_hash|
      if !consolidated_hash.key?(name)
        consolidated_hash[name] = detail_hash
        count = 1
      else
        count += 1
      end
      consolidated_hash[name][:count] = count
    end
  end
  consolidated_hash
end

def apply_coupons(cart, coupons)
  # code here
  applied_hash = {}
  cart.each do |item, detail| # "AVOCADO" => {}
    count = 0
    applied_hash[item] = detail
    if coupons.size > 0
      coupons.each do |food| #{}
        food.each do |key, value| #key = :item, value = "AVOCADO"
          if item == food[:item]
            if applied_hash[item][:count] >= food[:num]
              applied_hash[item][:count] -= food[:num] # 5 -2 -2
              applied_hash["#{item} W/COUPON"] = {:price => food[:cost], :clearance => detail[:clearance], :count => count += 1}
            end
          else
            count = 0
          end
        end
      end
    end
  end
  applied_hash
end

def apply_clearance(cart)
  # code here
  clearance_cart = cart
  cart.each do |item, detail|
    detail.each do |category, value| #category = :price, value = 2.40
      if value == true
        clearance_cart[item][:price] = (detail[:price] * 0.8).round(1)
      end
    end
  end
  clearance_cart
end

def checkout(cart, coupons)
  # code here
  c_cart = consolidate_cart(cart)
  acoup_cart = apply_coupons(c_cart, coupons)
  final_cart = apply_clearance(acoup_cart)
  total = 0
  final_cart.each do |item, detail| #{"BEER"=>{:price=>13.0, :clearance=>false, :count=>10}}
    detail.each do |category, value|
      if category == :count
        count = 0
        while count < detail[:count]
          count += 1
          total += detail[:price]
        end
      end
    end
  end
  total = (total * 0.9).round(1) if total > 100
  total
end
