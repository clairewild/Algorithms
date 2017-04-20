require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable

  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    list = bucket(key)
    list.include?(key)
  end

  def set(key, val)
    list = bucket(key)
    if list.include?(key)
      list.update(key, val)
    else
      @count += 1
      resize! if @count > num_buckets
      new_list = bucket(key)
      new_list.append(key, val)
    end
  end

  def get(key)
    list = bucket(key)
    list.get(key)
  end

  def delete(key)
    @count -= 1
    list = bucket(key)
    list.remove(key) if list.include?(key)
  end

  def each
    @store.each do |list|
      list.each do |node|
        yield(node.key, node.val)
      end
    end
  end

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private
  def num_buckets
    @store.length
  end

  def resize!
    new_num_buckets = num_buckets * 2
    new_store = Array.new(new_num_buckets) { LinkedList.new }

    self.each do |key, val|
      i = key.hash % new_num_buckets
      new_store[i].append(key, val)
    end

    @store = new_store
  end

  def bucket(key)
    @store[key.hash % num_buckets]
  end
end
