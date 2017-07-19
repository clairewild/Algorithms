require_relative 'bst_node'

class BinarySearchTree
  def initialize(val)
    @root = BSTNode.new(val)
  end

  def find(el)
    current_node = @root
    while current_node.left || current_node.right
      case current_node.val <=> el
      when 1
        current_node.left ? current_node = current_node.left : break
      when 0
        return current_node
      when -1
        current_node.right ? current_node = current_node.right : break
      end
    end
    nil
  end

  def insert(el)
    parent = @root
    depth = 1
    while parent.left || parent.right
      if el <= parent.val
        parent.left ? parent = parent.left : break
      else
        parent.right ? parent = parent.right : break
      end
      depth += 1
    end
    node = BSTNode.new(el)
    node.parent = parent
    node.depth = depth
    el < parent.val ? parent.left = node : parent.right = node
  end

  # Would be better to randomize removing from left and right sides if node has 2 children
  def delete(val)
    node = find(val)
    if node.left
      current_node = node.left
      current_node = current_node.right while current_node.right
    elsif node.right
      current_node = node.right
      current_node = current_node.left while current_node.left
    else
      current_node = node
    end
    node.val = current_node.val
    current_node.remove_self!
  end

  def is_balanced?(node = @root)
    if node.left && node.right
      diff = (height(node.left) - height(node.right)).abs
      both_balanced? = is_balanced?(node.left) && is_balanced?(node.right)
      return true if diff <= 1 && both_balanced?
    elsif node.left
      return true if height(node.left) <= 1
    elsif node.right
      return true if height(node.right) <= 1
    else
      return true
    end
    false
  end

  def in_order_vals
    nodes = in_order_traversal
    nodes.map { |node| node.val }
  end

  def in_order_traversal(node = @root)
    return [node] unless node.left || node.right

    while node.left
      node = node.left
    end

    res = [node]
    until node.parent.nil?
      if node.right
        res += in_order_traversal(node.right)
      end
      node = node.parent
      res << node
    end

    if node.right
      res += in_order_traversal(node.right)
    end

    return res
  end

  def maximum
    current_node = @root
    current_node = current_node.right while current_node.right
    current_node.val
  end

  # Height of tree should equal the depth of the lowest node
  def height(node = @root)
    nodes = in_order_traversal
    nodes.map { |node| node.depth }.max
  end
end
