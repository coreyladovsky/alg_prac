require 'byebug'

class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    @prc = prc
    @store = []
  end

  def count
    @store.length
  end

  def extract
    @store[0], @store[-1] = @store[-1], @store[0]
    popped = @store.pop
    BinaryMinHeap.heapify_down(@store, 0)
    popped 
  end

  def peek
    @store[0]
  end

  def push(val)
    @store << val
    BinaryMinHeap.heapify_up(@store, @store.length - 1)

  end

  public
  def self.child_indices(len, parent_index)
    children = []
    if (2 * parent_index + 1) < len
      children << (2 * parent_index + 1)
    end
    if (2 * parent_index + 2) < len
      children << (2 * parent_index + 2)
    end
    children
  end

  def self.parent_index(child_index)
    raise "root has no parent" unless child_index > 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    children = self.child_indices(len, parent_idx)
    return array if children.all? { |child| prc.call(array[parent_idx], array[child]) != 1 }
    child1, child2 = children
    child_idx = child2 && prc.call(array[child2], array[child1]) == -1 ? child2 : child1
    array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
    parent_idx = child_idx
    self.heapify_down(array, parent_idx, len, &prc)
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    return array if child_idx <= 0
    parent_idx = self.parent_index(child_idx)
    return array if prc.call(array[parent_idx], array[child_idx]) != 1
    array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
    child_idx = parent_idx
    self.heapify_up(array, child_idx, len, &prc)
  end
end
