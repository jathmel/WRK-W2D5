require 'byebug'

class Node
  attr_accessor :key, :val, :next, :prev

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
    # optional but useful, connects previous link to next link
    # and removes self from list.
    self.prev.next = self.next
    self.next.prev = self.prev

  end
end

class LinkedList
    include Enumerable

  attr_reader :sentinel_head, :sentinel_tail
  def initialize
    @sentinel_head = Node.new
    @sentinel_tail = Node.new
    @sentinel_head.next = @sentinel_tail
    @sentinel_tail.prev = @sentinel_head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @sentinel_head.next
  end

  def last
    @sentinel_tail.prev
  end

  def empty?
    sentinel_head.next == sentinel_tail
    # if sentinel_head.next == sentinel_tail
    #   true
    # else
    #   false
    # end
  end

  def get(key)
    node = get_node(key)

    node ? node.val : nil
    # self.each do |node|
    #   if node.key == key
    #     return node.val
    #   end
    # end
    # nil
  end

  def get_node(key)
    self.each do |node|
      if node.key == key
        return node
      end
    end
    nil
  end

  def include?(key)
    !get(key).nil?
    # return true unless get(key).nil?
    # false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    end_node = sentinel_tail.prev

    new_node.next = sentinel_tail
    new_node.prev = end_node
    end_node.next = new_node
    sentinel_tail.prev = new_node
  end

  def update(key, val)
    return false unless include?(key)
    node = get_node(key)
    node.val = val
  end

  def remove(key)
    return false unless include?(key)
    node = get_node(key)
    node.remove
  end

  def each(&prc)
    prc ||= Proc.new
    node = sentinel_head
    until node.next == sentinel_tail
      node = node.next
      prc.call(node)
    end
  end
  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
