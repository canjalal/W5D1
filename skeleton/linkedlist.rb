class Node
    attr_accessor :value, :next
    def initialize(val)
        @value = val
        @next = nil
    end
end

class LinkedList

    def initialize
        @head = nil
        @tail = nil
    end

    def push(val)
        new_node = Node.new(val)
        
    end
end