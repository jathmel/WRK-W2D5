require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count, :max, :prc
  attr_accessor :store, :map
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if map.include?(key)
      update_node!(map[key])
    else
      value = prc.call(key)
      calc!(key, value)
    end
    value
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key, value)
    # suggested helper method; insert an (un-cached) key
    store.append(key, value)
    new_node = store.last
    map[key] = new_node
    eject! if count > max
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    key = node.key
    node.remove
    store.append(node.key, node.val)
    map[key] = store.last
  end

  def eject!
    node = store.first
    node.remove
    map.delete(node.key)
  end
end
