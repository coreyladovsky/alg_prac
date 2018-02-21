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
    (child_idx - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
  end
end
