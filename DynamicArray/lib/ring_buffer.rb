require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @capacity = 8
    @store = StaticArray.new(@capacity)
    @length = 0
    @start_idx = 0
  end

  # O(1)
  def [](index)
    check_index(index)
    i = (index + @start_idx) % @capacity
    @store[i]
  end

  # O(1)
  def []=(index, val)
    check_index(index)
    i = (index + @start_idx) % @capacity
    @store[i] = val
  end

  # O(1)
  def pop
    popped = self[@length - 1]
    self[@length - 1] = nil
    @length -= 1
    popped
  end

  # O(1) ammortized
  def push(val)
    @length += 1
    resize!
    self[@length - 1] = val
  end

  # O(1)
  def shift
    shifted = self[0]
    @start_idx = (@start_idx + 1) % @capacity
    @length -= 1
    shifted
  end

  # O(1) ammortized
  def unshift(val)
    @length += 1
    resize!
    @start_idx = (@start_idx - 1) % @capacity
    self[0] = val
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" unless index.between?(0, @length - 1)
  end

  def resize!
    if @length > @capacity
      new_capacity = @capacity * 2
      new_array = StaticArray.new(new_capacity)

      (0...@capacity).each do |i|
        new_array[i] = self[i]
      end
      (@capacity...new_capacity).each do |j|
        new_array[j] = nil
      end

      @capacity = new_capacity
      @store = new_array
      @start_idx = 0
    end
  end
end
