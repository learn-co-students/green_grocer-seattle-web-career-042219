coupons.each do |coupon|
  name = coupon[:item]
  if cart[name] && cart[name][:count] >= coupon[:num]
    if cart["#{name} W/COUPON"]
      cart["#{name} W/COUPON"][:count] += 1
    else
      cart["#{name} W/COUPON"] = {:count => 1, :price => coupon[:cost]}
      cart["#{name} W/COUPON"][:clearance] = cart[name][:clearance]
    end
    cart[name][:count] -= coupon[:num]
  end
end
cart


new_cart = {}
coupons.each do |key|
  item = key[:item]
  if cart[item] && cart[item][:count] >= key[:num]
      if cart["#{item} W/COUPON"]
        cart["#{item} W/COUPON"][:count] += 1
      else
        cart["#{item} W/COUPON"] = {:count => 1, :price => key[:cost]}
        cart["#{item} W/COUPON"][:clearance] = cart[item][:clearance]
      end
    cart[item][:count] -= key[:num]
  end
end
cart
end



# code here
bigger_discount = {}
new_cart = {}
if coupons == []
  return cart
else
cart.each do |key, value|
  coupons.each do |discount|
  if discount[:item] == key
    if discount[:num] <= cart[key][:count]
      if new_cart["#{key} W/COUPON"].nil?
        new_cart["#{key} W/COUPON"] = {}
        new_cart["#{key} W/COUPON"][:count] = 0
        new_cart["#{key} W/COUPON"][:price] = 0
        new_cart["#{key} W/COUPON"][:clearance] = cart[key][:clearance]
        new_cart[key] = value
        count = cart[key][:count]
        disc = discount[:num]

      end
      #binding.pry
      while (count - disc) >= 0
        if true
          new_cart["#{key} W/COUPON"][:price] = new_cart["#{key} W/COUPON"][:price] + (discount[:cost])
        else
        new_cart["#{key} W/COUPON"][:price] = new_cart["#{key} W/COUPON"][:price] + discount[:cost]
      end
        new_cart["#{key} W/COUPON"][:count] += 1
        new_cart[key][:count] -= disc
        count -= disc
      end
    end
  else new_cart[key] = value
  end
end
end
end
new_cart
