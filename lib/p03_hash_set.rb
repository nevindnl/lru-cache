require_relative 'p02_hashing'
require_relative 'p01_int_set'

class HashSet < ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 8)
    super
  end

  # def insert(key)
  #   super(key)
  # end
  #
  # def include?(key)
  #   super(key)
  # end
  #
  # def remove(key)
  #   super(key)
  # end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num.hash % num_buckets]
  end
  # 
  # def num_buckets
  #   @store.length
  # end
  #
  # def resize!
  # end
end
