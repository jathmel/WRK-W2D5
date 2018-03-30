require_relative 'p02_hashing'
require_relative 'p04_linked_list'
require_relative 'p03_hash_set'
require 'byebug'

class HashMap
  include Enumerable
  attr_accessor :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket = bucket(key)
    store[bucket].each do |node|
      return true if node.key == key
    end
    false
  end

  def set(key, val)
    # debugger
    resize! if count == num_buckets

    bucket = bucket(key)
    if include?(key)
      store[bucket].update(key, val)
    else
      store[bucket].append(key, val)
      self.count += 1
    end
  end

  def get(key)
    bucket = bucket(key)
    store[bucket].each do |node|
      return node.val if node.key == key
    end
    nil
  end

  def delete(key)
    bucket = bucket(key)
    store[bucket].remove(key)
    self.count -= 1
  end

  def each(&prc)
    prc ||= Proc.new
    store.each do |bucket|
      bucket.each do |node|
        prc.call(node.key, node.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end


    def resize!
      # new_arr = Array.new(num_buckets) {LinkedList.new}
      # self.store += new_arr
      old_store = self.store
      self.store = Array.new(num_buckets * 2) {LinkedList.new}

      self.count = 0

      old_store.each do |bucket|
        bucket.each do |node|
          set(node.key, node.val)
        end
      end
    end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    key.hash % num_buckets
  end
end
