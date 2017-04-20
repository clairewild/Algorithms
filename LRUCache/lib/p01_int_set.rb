class MaxIntSet
  def initialize(max)
    @set = Array.new(max)
    @max = max
  end

  def insert(num)
    validate!(num)
    @set[num] = true
  end

  def remove(num)
    @set[num] = nil
  end

  def include?(num)
    @set[num] != nil
  end

  private
  def is_valid?(num)
    num >= 0 && num <= @max
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].select! { |el| el != num }
  end

  def include?(num)
    self[num].include?(num)
  end

  private
  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    @count += 1
    resize! if @count > num_buckets
    self[num] << num
  end

  def remove(num)
    @count -= 1
    self[num].select! { |el| el != num }
  end

  def include?(num)
    self[num].include?(num)
  end

  private
  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_num_buckets = num_buckets * 2
    new_store = Array.new(new_num_buckets) { Array.new }

    @store.each do |bucket|
      bucket.each do |el|
        i = el % new_num_buckets
        new_store[i] << el
      end
    end
    @store = new_store
  end
end
