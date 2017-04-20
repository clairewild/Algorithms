require_relative "heap"

class Array
  def heap_sort!
    prc = Proc.new { |x, y| y <=> x }
    heap = BinaryMinHeap.new(&prc)

    self.each do |el|
      heap.push(el)
    end

    i = 0
    while i < self.length
      self[i] = heap.extract
      i += 1
    end
  end
end
