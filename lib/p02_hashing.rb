class Fixnum
end

class Array
  def hash
    self.each_with_index.inject(0) do |sum, (el, i)|
      sum + el.hash * (i + 1)
    end % 541
  end
end

class String
  def hash
    alphabet = ('a'..'z').to_a
    self.chars.map{ |c| alphabet.index(c.downcase) + 1 }.hash
  end
end

class Hash
  def hash
    self.keys.sort.hash + self.values.sort.hash
  end
end
