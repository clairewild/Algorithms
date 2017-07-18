class BSTNode
  attr_accessor :val, :right, :left, :parent

  def initialize(val)
    @val = val
    @right = nil
    @left = nil
    @parent = nil
  end
end
