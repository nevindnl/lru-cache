class Link
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
end

class LinkedList
  include Enumerable

  def initialize
    @head = Link.new(:head, nil)
    @tail = Link.new(:tail, nil)
    @head.next, @tail.prev = @tail, @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    get_link(key).nil? ? nil : get_link(key).val
  end

  def get_link(key)
    find {|link| link.key == key}
  end

  def include?(key)
    any? {|link| link.key == key}
  end

  def insert(key, val)
    if include?(key)
      get_link(key).val = val
    else
      old_last = @tail.prev
      new_link = Link.new(key, val)

      old_last.next, new_link.prev = new_link, old_last
      new_link.next, @tail.prev = @tail, new_link
    end
    new_link
  end

  def remove(key)
    return nil unless include?(key)

    target = get_link(key)
    target.prev.next, target.next.prev = target.next, target.prev
  end

  def each(&prc)
    i = @head.next
    until i == @tail
      prc.call(i) if block_given?
      i = i.next
    end
    self
  end


  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
