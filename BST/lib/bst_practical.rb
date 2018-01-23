
require 'binary_search_tree'

def kth_largest(tree_node, k)
  bst = BinarySearchTree.new
  arr = bst.in_order_traversal(tree_node)
  val = arr[k * -1]
  bst.find(val, tree_node)
end
