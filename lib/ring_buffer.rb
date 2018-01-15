require_relative "static_array"

class RingBuffer < StaticArray
  attr_reader :length

  def initialize
    # super
    @store = StaticArray.new(8)
    @start_idx = nil
    @end_idx = nil
    @length = 0
    @capacity = 8
  end

  # O(1)
  def [](index)
    raise_error
    check_index(index + @start_idx)
    @store[@start_idx + index]
  end

  # O(1)
  def []=(index, val)
    @store[index] = val
  end

  # O(1)
  def pop
    raise_error
    @length -= 1
    popped = @store[@end_idx]
    @end_idx -= 1
    popped
  end

  # O(1) ammortized
  def push(val)
    resize!
    @length += 1
    if start_idx.nil?
      @start_idx = 0
      @end_idx = 0
    else
      @end_idx += 1
    end
      @store[@end_idx] = val
  end

  # O(1)
  def shift
    raise_error
    @length -= 1
    shifted = @store[@start_idx]
    @start_idx += 1
    shifted
  end

  # O(1) ammortized
  def unshift(val)
    resize!
    @length += 1
    if start_idx.nil?
      @start_idx = 0
      @end_idx = 0
    else
      @start_idx -= 1
    end
    @store[@start_idx] = val
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    if @store[index].nil?
      raise 'index out of bounds'
    end
  end

  def raise_error
    if @length == 0
      raise 'index out of bounds'
    end
  end

  def resize!
    if @length  == @capacity
      @store = @store[0..start_idx] + Array.new(@capacity) + @store[@end_idx..-1]
      @capacity *= 2
    end
  end
end
