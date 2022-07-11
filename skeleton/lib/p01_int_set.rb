class MaxIntSet
  attr_reader :store
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    validate!(num)
    @store[num] == true
  end

  private

  def is_valid?(num)
    num.between?(0, @store.length - 1) # not including max
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num % num_buckets] << num unless self.include?(num)
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    self.resize! if count == num_buckets
    unless self.include?(num)
      @count += 1
      @store[num % num_buckets] << num unless self.include?(num)
    end



  end

  def remove(num)
    if self[num].include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  # def inspect
    # @store.each do |bucket|
    #   puts "Bucket #{bucket} contains: "
    #   p bucket
    #   puts
    # end
  # end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    num_buckets = @store.length*2
    temp = Array.new(num_buckets) {Array.new}
    @store.flatten.each do |num| # 1-level flatten should be O(n)
      temp[num % num_buckets] << num
    end
    @store = temp # O(1) because we're just reassigning the pointer
  end
end
