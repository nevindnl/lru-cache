require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
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
    link = @map.get(key)

    if link
      link.val
    else
      calc!(key)
      @map.get(key).val
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    eject! if @map.count == @max

    @store.insert(key, val= @prc.call(key))
    @map.set(key, @store.last)
  end

  def update_link!(link)
    @store.remove(link.key)
    @store.insert(link.key, link.val)
  end

  def eject!
    key = @store.first.key

    @store.remove(key)
    @map.delete(key)
  end
end
