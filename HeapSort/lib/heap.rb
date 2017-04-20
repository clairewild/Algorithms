class BinaryMinHeap
  def initialize(&prc)
    @store = []
    @prc = prc || Proc.new { |x, y| x <=> y }
  end

  def count
    @store.length
  end

  def extract
    @store[0], @store[-1] = @store[-1], @store[0]
    popped = @store.pop
    BinaryMinHeap.heapify_down(@store, 0, @prc)
    popped
  end

  def peek
    @store.first
  end

  def push(val)
    @store << val
    BinaryMinHeap.heapify_up(@store, count - 1, @prc)
  end

  protected
  attr_accessor :prc, :store

  public
  def self.child_indices(len, parent_index)
    indices = []
    i = 2 * parent_index + 1
    j = 2 * parent_index + 2
    indices << i if i < len
    indices << j if j < len
    indices
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    i = parent_idx
    while i < array.length
      child_indices = BinaryMinHeap.child_indices(array.length, i)
      break unless child_indices[0] # may not need
      x = array[i]
      y = array[child_indices[0]]
      z = (child_indices[1]) ? array[child_indices[1]] : nil

      if z
        smallest = (prc.call(y, z) == -1) ? y : z
        small_idx = (smallest == y) ? child_indices[0] : child_indices[1]
      else
        smallest = y
        small_idx = child_indices[0]
      end

      if prc.call(x, smallest) == 1
        array[i], array[small_idx] = array[small_idx], array[i]
      end
      i += 1
    end
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    i = child_idx
    while i > 0
      parent_idx = BinaryMinHeap.parent_index(i)
      x = array[i]
      y = array[parent_idx]

      if prc.call(x, y) == -1
        array[i], array[parent_idx] = array[parent_idx], array[i]
      end
      i -= 1
    end
    array
  end
end
