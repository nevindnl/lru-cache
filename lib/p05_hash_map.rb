require_relative 'p02_hashing'
require_relative 'p04_linked_list'
require_relative 'p03_hash_set'

class HashMap
  attr_reader :count

  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    @count += 1 unless include?(key)
    bucket(key).insert(key, val)

    resize! if @count == num_buckets
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    @count -= 1 if include?(key)
    bucket(key).remove(key)
  end

  def each(&prc)
    @store.each do |bucket|
      bucket.each do |link|
        prc.call(link.key, link.val) if block_given?
      end
    end
  end

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
    new_length = num_buckets + @count

    new_store = @store.dup
    @store = Array.new(new_length) { LinkedList.new }
    @count = 0

    new_store.each do |linklist|
      linklist.each do |link|
        set(link.key, link.val)
      end
    end
  end

  def bucket(key)
    @store[key.hash % num_buckets]
  end
end
