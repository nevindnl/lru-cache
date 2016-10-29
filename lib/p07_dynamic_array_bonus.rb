class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  include Enumerable

  attr_reader :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @cap_index = capacity - 1

    @count = 0
    @size = capacity - 1
  end

  def [](i)
    i = @count + i if i < 0

    return nil unless i.between?(0, @size - 1)

    layer = @store

    (i / @cap_index).times do layer = layer[@cap_index] end
    layer[i % @cap_index]
  end

  def []=(i, val)
    i = @count + i if i < 0

    return nil unless i.between?(0, @size - 1)

    layer = @store

    (i / @cap_index).times do layer = layer[@cap_index] end
    layer[i % @cap_index] = val
  end

  def include?(val)
    @count.times do |i|
      return true if self[i] == val
    end
    false
  end

  def push(val)
    resize! if @count == @size

    self[@count] = val
    @count += 1

    val
  end

  def unshift(val)
    resize! if @count == @size

    @count.downto(1) do |i|
      self[i] = self[i - 1]
    end

    self[0] = val
    @count += 1

    val
  end

  def pop
    el = self[@count - 1]
    self[@count - 1] = nil

    @count -= 1
    el
  end

  def shift
    el = self[0]

    @count.times do |i|
      self[i] = self[i + 1]
    end

    self[@count - 1] = nil

    @count -= 1
    el
  end

  def first
    self[0]
  end

  def last
    self[-1]
  end

  def each &prc
    @count.times do |i|
      prc.call(self[i])
    end
    self
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    # ...

    each_with_index do |el, i|
      return false unless el == other[i]
    end

    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    layer = @store

    (@size / @cap_index - 1).times do layer = layer[@cap_index] end
    layer[@cap_index] = StaticArray.new(@cap_index + 1)

    @size += @cap_index
  end
end
