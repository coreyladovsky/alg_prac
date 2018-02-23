require_relative "heap"

class Array
  def heap_sort!
    prc ||= Proc.new { |el1, el2| el2 <=> el1 }
    idx = 0
    while idx < self.length
      BinaryMinHeap.heapify_up(self, idx, self.length - 1, &prc )
      idx += 1
    end

    while idx >= 0
      self[0], self[idx] = self[idx], self[0]
      BinaryMinHeap.heapify_down(self, 0, idx, &prc)
      idx -= 1
    end

    self
  end
end
