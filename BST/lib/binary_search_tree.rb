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
    return nil if tree_node.nil?
    return tree_node if tree_node.value == value
    if tree_node.value < value
      find(value, tree_node.right)
    else
      find(value, tree_node.left)
    end
  end

  def delete(value)
    node = find(value)
    if node.left.nil? && node.right.nil?
      return @root = nil if @root == node
      parent_node = find_parent(@root, node)
      parent_node.left == value ? parent_node.left = nil : parent_node.right = nil

    elsif node.left && !node.right || !node.left && node.right
      parent_node = find_parent(@root, node)
      single_child_promotion(parent_node, node, value)

    elsif node.left && node.right
      parent_node = find_parent(@root, node)
      max_decendent = maximum(node.left)
      max_parent = find_parent(@root, max_decendent)
      if parent_node.left == node
        parent_node.left = max_decendent
      else
        parent_node.right = max_decendent
      end
      if max_decendent.left
        max_parent.right = max_decendent.left
      end
    end


  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    tree_node.right ? maximum(tree_node.right) : tree_node
  end

  def depth(tree_node = @root)
    return 0 if tree_node.nil?
    return 0 if tree_node.left.nil? && tree_node.right.nil?
    if tree_node.left
      left_sum = 1 + depth(tree_node.left)
    else
      left_sum = 0
    end
    if tree_node.right
      right_sum = 1 + depth(tree_node.right)
    else
      right_sum = 0
    end

    [left_sum, right_sum].max
  end

  def is_balanced?(tree_node = @root)
    return true if tree_node.nil?

    depth1 = depth(tree_node.right)
    depth2  = depth(tree_node.left)
    if (depth1 - depth2).abs <= 1 &&
      is_balanced?(tree_node.left) &&
      is_balanced?(tree_node.right)
      return true
    end
    false

  end

  def in_order_traversal(tree_node = @root, arr = [])
    if tree_node.left.nil? && tree_node.right.nil?
      return arr.push(tree_node.value)
    end

    if tree_node.left
      left = in_order_traversal(tree_node.left, arr)
      arr.concat(left)
    # else
    #   left = []
    end
    if tree_node.right
      right = in_order_traversal(tree_node.right, arr)
      arr.concat(right)
    # else
      # right = []
    end

    return arr
  end


  private
  # optional helper methods go here:

  def single_child_promotion(parent_node, node, value)
    if parent_node.left == value
      if node.left
        parent_node.left = node.left
      else
        parent_node.left = node.right
      end
    else
      if node.left
        parent_node.right = node.left
      else
        parent_node.right = node.right
      end
    end
  end

  def find_parent(parent, node)
    if (parent.right == node || parent.left == node)
      return parent
    else
      find_parent(parent.left, node) || find_parent(parent.right, node)
    end
  end


  def child_insert(node, value)

  end

end
