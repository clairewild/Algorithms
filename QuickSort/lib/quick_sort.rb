class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length < 2
    pivot = array.shift
    left = array.select { |el| el < pivot }
    right = array.select { |el| el >= pivot }
    QuickSort.sort1(left) + [pivot] + QuickSort.sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return array if length < 2
    pivot = partition(array, start, length, &prc)
    QuickSort.sort2!(array, start, pivot - start, &prc)
    QuickSort.sort2!(array, pivot + 1, length - pivot - 1, &prc)
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    pivot = array[start]
    barrier = start + 1
    (start + 1...start + length).each do |i|
      case prc.call(array[i], pivot)
        when -1
          array[i], array[barrier] = array[barrier], array[i]
          barrier += 1
      end
    end
    array[start], array[barrier - 1] = array[barrier - 1], pivot
    barrier - 1
  end
end
