class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    temp = @prev
    temp.next = @next
    temp = @next
    temp.prev = @prev
    @prev = nil
    @next = nil
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    self.empty? ? nil : @head.next

  end

  def last
    self.empty? ? nil : @tail.prev
  end

  def empty?
    @head.next == @tail && @tail.prev == @head

  end

  def get(key)
    self.each do |node|
      return node.val if node.key == key
    end
  end

  def include?(key)
    self.each do |node|
      return true if (node.key == key)
    end
    false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    oldlast = @tail.prev
    oldlast.next = new_node
    new_node.prev = oldlast
    new_node.next = @tail
    @tail.prev = new_node
  end

  def update(key, val)
    self.each do |node|
      if (node.key == key)
        node.val = val
        return
      end
    end
  end

  def remove(key)
    self.each do |node|
      if (node.key == key)
        node.remove
        return
      end
    end
  end

  def each(&prc)

    return if self.empty?

    currpos = self.first

    until(currpos == @tail)
      prc.call(currpos)
      currpos = currpos.next
    end

  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
