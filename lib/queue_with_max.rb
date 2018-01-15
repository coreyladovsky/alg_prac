# Implement a queue with #enqueue and #dequeue, as well as a #max API,
# a method which returns the maximum element still in the queue. This
# is trivial to do by spending O(n) time upon dequeuing.
# Can you do it in O(1) amortized? Maybe use an auxiliary storage structure?

# Use your RingBuffer to achieve optimal shifts! Write any additional
# methods you need.

require_relative 'ring_buffer'

class QueueWithMax < RingBuffer
  attr_accessor :store, :max

  def initialize
    super
    @store = RingBuffer.new
    @length = 0
    @max = nil
  end

  def enqueue(val)
    if @max.nil? || @max < val
      @max = val
    end
    @store.push(@max)
    @length += 1
  end

  def dequeue
    @length -= 1
    final = @store.shift
    if final == @max
      recalc_max!
    end
    final
  end

  def recalc_max!
    max = nil
    idx = 0
    while idx < @length
      if  max.nil? || @store[idx] > max
        max = @store[idx]
      end
      idx += 1
    end

    @max = max
  end


  def length
    @length
  end

end
