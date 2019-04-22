require "pry"

def consolidate_cart(cart)
  new_hash = {}
  cart.each do |item|
    item.each do |key, value|
      if new_hash[key] == nil
        new_hash[key] = value
        new_hash[key][:count] = 1
      else
        new_hash[key][:count] += 1
      end
    end
  end

  new_hash
end

def apply_coupons(cart, coupons)
  new_hash ={}
   cart.each do |name, details|
    #name = avacado
    #details = {:price=>3.0, :clearance=>true, :count=>2}
    count = 0
    new_hash[name] = details

      if coupons.size > 0
        coupons.each do |coupon|
          coupon.each do |key, value|
            #key = :item :num :cost
            #value = avacado, 2, $3
            if name == coupon[:item]
                if coupon[:num] <= new_hash[name][:count]
                   new_hash[name][:count] -= coupon[:num]

                   new_hash["#{name} W/COUPON"] = {
                              :price => coupon[:cost],
                              :clearance => details[:clearance],
                              :count => count += 1
                              }
                  end
            else
            count = 0
            end
          end
        end
      end
    end
  new_hash
end

def apply_clearance(cart)
  cart.each do |name, details|
    if details[:clearance] == true
      details[:price] = (details[:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  final = 0.00
  cc = consolidate_cart(cart)
  ap = apply_coupons(cc, coupons)
  ac = apply_clearance(ap)

    ac.each do |name, details|
      #name = "BEETS"
      #details = {:price=>2.5, :clearance=>false, :count=>1}
      final += details[:price] * details[:count]
    end

    if final > 100
      final = final * 0.90
    else final
    end

end
