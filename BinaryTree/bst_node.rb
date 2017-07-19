class BSTNode
  attr_accessor :val, :right, :left, :parent, :depth

  def initialize(val)
    @val = val
    @right = nil
    @left = nil
    @parent = nil
    @depth = 1
  end

  def remove_self!
    @left = nil
    @right = nil
    if @parent
      @parent.left = nil if @parent.left.val == @val
      @parent.right = nil if @parent.right.val == @val
    end
  end
end
