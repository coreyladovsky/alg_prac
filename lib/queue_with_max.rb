# Implement a queue with #enqueue and #dequeue, as well as a #max API,
# a method which returns the maximum element still in the queue. This
# is trivial to do by spending O(n) time upon dequeuing.
# Can you do it in O(1) amortized? Maybe use an auxiliary storage structure?

# Use your RingBuffer to achieve optimal shifts! Write any additional
# methods you need.

require_relative 'ring_buffer'

class QueueWithMax < RingBuffer
  attr_accessor :store

  def initialize
    super
    @length = 0
    @max = nil
    @in_stack = []
    @out_stack = []
  end

  def enqueue(val)
    if @in_stack.length == 0
      @in_stack << [val, val]
    else
      @in_stack << [ val, [@in_stack.last[1], val].max ]
    end
    @length += 1
  end

  def dequeue
    if @out_stack.empty?
      switch_stack
    end
    @out_stack.pop[0]
    @length -= 1
  end

  def max
    if !@in_stack.empty? && !@out_stack.empty?
      [@in_stack.last.last, @out_stack.last.last].max
    elsif  @in_stack.empty? && @out_stack.empty?
      return nil
    elsif  @in_stack.empty?
      @out_stack.last.last
    else
      @in_stack.last.last
    end
  end


  def length
    @length
  end

  protected

  def switch_stack
    until @in_stack.empty?
      if @out_stack.empty?
        last = @in_stack.pop[0]
        @out_stack << [last, last]
      else
        last = @in_stack.pop[0]
        @out_stack << [ last, [last, @out_stack.last.last].max ]
      end
    end
  end

end
