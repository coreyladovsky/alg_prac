require 'byebug'

class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
  end

  def count
    @store.length
  end

  def extract
    @store[0], @store[-1] = @store[-1], @store[0]

  end

  def peek
    @store[0]
  end

  def push(val)
    @store << val
    # parent = @store[count / 2]
    # while parent < val
    #
    # end
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
    continue = true
    while continue
      child1, child2 = BinaryMinHeap.child_indices(len, parent_idx)
      break if !child1 && !child2

      if array[parent_idx] > array[child1] || (!!array[child2] && array[parent_idx] > array[child2])
        if child1 && child2
          child_idx = array[child1] < array[child2] ? child1 : child2
        else
          child_idx = child1
        end
        array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
        parent_idx = child_idx
      else
        continue = false
      end
    end
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
  end
end
