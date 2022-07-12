class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    self.resize! if count == num_buckets
    unless self.include?(key)
      @count += 1
      @store[key.hash % num_buckets] << key unless self.include?(key)
    end
  end

  def include?(key)
    self[key].include?(key)
    
  end

  def remove(key)
    if self[key].include?(key)
      self[key].delete(key)
      @count -= 1
    end
  end

  private

  def [](key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    num_buckets = @store.length*2
    temp = Array.new(num_buckets) {Array.new}
    @store.flatten.each do |key| # 1-level flatten should be O(n)
      temp[key.hash % num_buckets] << key
    end
    @store = temp # O(1) because we're just reassigning the pointer
  end
end
