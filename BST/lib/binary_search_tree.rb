# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.

require("bst_node")

class BinarySearchTree
  attr_reader :root
  def initialize
    @root = nil
  end

  def insert(value, node = @root)
    if node.nil?
      @root = BSTNode.new(value)
      return
    else
      if node.value > value
        if node.left
          insert(value, node.left)
        else
          node.left = BSTNode.new(value)
        end
      else
        if node.value < value
          if node.right
            insert(value, node.right)
          else
            node.right = BSTNode.new(value)
          end
        end
      end
    end
  end

  def find(value, tree_node = @root)
  end

  def delete(value)
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
  end

  def depth(tree_node = @root)
  end

  def is_balanced?(tree_node = @root)
  end

  def in_order_traversal(tree_node = @root, arr = [])
  end


  private
  # optional helper methods go here:

  def child_insert(node, value)

  end

end
