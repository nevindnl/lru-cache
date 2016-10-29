class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
    @max = max
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
    num <= @max && num >= 0
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
    self[num] << num unless include? num
  end

  def remove(num)
    self[num].delete num
  end

  def include?(num)
    self[num].include? num
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

class ResizingIntSet < IntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    super
    @count = 0
  end

  def insert(num)
    super
    @count += 1

    resize! if @count >= num_buckets
  end

  def remove(num)
    super
    @count -= 1
  end

  def inspect
    num_buckets
  end

  private

  def resize!
    new_length = num_buckets + @count

    new_store = @store.dup
    @store = Array.new(new_length) { Array.new }

    new_store.flatten.each do |el|
      num = el % num_buckets
      self[num] << el
    end
  end
end
