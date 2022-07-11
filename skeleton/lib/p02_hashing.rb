class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    temp_str = "#{self}"
    temp_str.hash
  end
end

class String
  def hash
    temp_arr = self.split("")
    hashint = temp_arr.inject(0) { |acc, ele| acc * Math::PI.to_s[acc % 17].to_i + ele.ord }
    return hashint.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    temp_str = "#{self.sort}"
    temp_str.hash
  end
end
