require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @store = []
    @length = 0
    @capacity = 8
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    @store[index] = value
  end

  # O(1)
  def pop
    raise_error
    @length -= 1
    @store.pop
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize!
    @length += 1
    @store << val
  end

  # O(n): has to shift over all the elements.
  def shift
    raise_error
    @length -= 1
    @store.shift
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize!
    @length += 1
    @store.unshift(val)
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    if @store[index].nil?
      raise 'index out of bounds'
    end
  end

  def raise_error
    if @store.empty?
      raise 'index out of bounds'
    end
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    if @length  == @capacity
      @store = @store + Array.new(@capacity)
      @capacity *= 2
    end
  end
end
