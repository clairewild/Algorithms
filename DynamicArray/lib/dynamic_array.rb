require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @capacity = 8
    @store = StaticArray.new(@capacity)
    @length = 0
  end

  # O(1)
  def [](index)
    validate!(index)
    @store[index]
  end

  # O(1)
  def []=(index, val)
    validate!(index)
    @store[index] = val
  end

  # O(1)
  def pop
    i = @length - 1
    validate!(i)
    popped = @store[i]
    @store[i] = nil
    @length -= 1
    popped
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    @length += 1
    resize!
    i = @length - 1
    @store[i] = val
  end

  # O(n): has to shift over all the elements.
  def shift
    validate!(0)
    @length -= 1
    shifted = @store[0]
    new_array = StaticArray.new(@capacity)
    (1...@capacity).each do |i|
      new_array[i - 1] = @store[i]
    end
    @store = new_array
    shifted
  end

  # O(n): has to shift over all the elements.
  def unshift(value)
    @length += 1
    resize!
    new_array = StaticArray.new(@capacity)
    new_array[0] = value
    (1...@length).each do |i|
      new_array[i] = @store[i - 1]
    end
    @store = new_array
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def validate!(index)
    raise "index out of bounds" unless index.between?(0, @length - 1)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    if @length > @capacity
      new_capacity = @capacity * 2
      new_array = StaticArray.new(new_capacity)

      (0...@capacity).each do |i|
        new_array[i] = @store[i]
      end
      (@capacity...new_capacity).each do |j|
        new_array[j] = nil
      end

      @capacity = new_capacity
      @store = new_array
    end
  end
end
