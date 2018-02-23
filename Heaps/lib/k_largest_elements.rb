require_relative 'heap'
require_relative 'heap_sort'

def k_largest_elements(array, k)
  heaped_array = array.heap_sort!
  heaped_array[array.length - k.. -1]
end
