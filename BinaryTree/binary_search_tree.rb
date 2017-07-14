require_relative 'bst_node'

class BinarySearchTree
  def initialize(val)
    @root = BSTNode.new(val)
  end

  def find(el)
    current_node = @root
    while current_node.left || current_node.right
      case current_node.val <=> el
      when -1
        current_node.left ? current_node = current_node.left : return nil
      when 0
        return current_node
      when 1
        current_node.right ? current_node = current_node.right : return nil
      end
    end
  end

  def recursive_find(el, current_node = @root)
    return current_node if el == current_node.val

    if el < current_node.val
      recursive_find(el, current_node.left)
    else
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

  def delete(el)
  end

  def is_balanced?
  end

  def in_order_traversal
  end

  def maximum
  end

  def depth
  end
end
