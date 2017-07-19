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

  def recursive_find(el, current_node = @root)
    return current_node if el == current_node.val

    if el < current_node.val
      return nil unless current_node.left
      recursive_find(el, current_node.left)
    else
      return nil unless current_node.right
      recursive_find(el, current_node.right)
    end
  end

  def insert(el)
    parent = @root
    while parent.left || parent.right
      if el <= parent.val
        parent.left ? parent = parent.left : break
      else
        parent.right ? parent = parent.right : break
      end
    end
    node = BSTNode.new(el)
    el < parent.val ? parent.left = node : parent.right = node
  end

  def in_order_vals
    nodes = in_order_traversal
    nodes.map { |node| node.val }
  end

  def in_order_traversal(node = @root)
    return [node] unless node.left || node.right

    stack = [node]
    while node.left
      node = node.left
      stack << node
    end

    res = [stack.pop]
    until stack.empty?
      node = res[-1]
      if node.right
        res += in_order_traversal(node.right)
      else
        node = stack.pop
        res << node
      end
    end

    node = res[-1]
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
end
