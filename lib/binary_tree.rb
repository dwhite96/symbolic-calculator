# List the component parts of the symbolic calculator problem:

# Tree
# Calculator
# Expression
  # Evaluate
    # Stack
  # Node
    # Operator
      # Addition
      # Subtraction
      # Multiplication
      # Division
  # Leaves
    # Left Operand
      # Number
      # Variable
    # Right Operand
      # Number
      # Variable

# First work on abstracting out addition of two numbers
# May need to create module containing base code needed for all classes
# Create expression class to represent expression tree structure
# Create subclasses to represent number, variable, operator definitions
# Create evaluate class to handle the simplification of the binary tree

# require "number"
# Dir[File.expand_path("../operators/*.rb", __FILE__)].each { |file| require file }


class BinaryTreeNode
  attr_accessor :value, :left, :right

  def initialize(value, left = nil, right = nil)
    @value = value
    @left = left
    @right = right
  end

  def leaf?
    left.nil? && right.nil?
  end
end

class ExpressionNode < BinaryTreeNode
  def evaluate
    self
  end

  def to_postfix
    if self.leaf?
      self.value
    else
      "#{self.left.to_postfix} #{self.right.to_postfix} #{self.value}"
    end
  end
end

class OperatorNode
  def initialize(value, left, right)
    @value = value
    @left = left
    @right = right
  end

  def evaluate
    self
    if @value == "+"
      self.addition
    end
  end

  def addition
    if @left.is_a?(NumericNode) && @right.is_a?(NumericNode)
      ExpressionNode.new(@left.value + @right.value, nil, nil)
    elsif @left.value == 0
      ExpressionNode.new(@right.value, nil, nil)
    elsif @right.value == 0
      ExpressionNode.new(@left.value, nil, nil)
    else
      self
    end
  end
end

class NumericNode < ExpressionNode; end

class VariableNode < ExpressionNode
  def simplify(bindings = {})
    # Convert variable to integer value if included in bindings hash
    if bindings.include?(value)
      bindings[value]
    else
      self
    end
  end
end

class Expression
  def initialize(expr)
    @expr = expr
  end

  def evaluate(bindings = {})
    stack = []

    @expr.split.each do |token|
      case token
      when /\A\d+\z/
        stack.push(NumericNode.new(token.to_i, nil, nil))
      when /\A[a-z]+\z/
        stack.push(VariableNode.new(token, nil, nil).simplify(bindings))
      when "+", "-", "*", "/"
        lhs, rhs = stack.pop(2)
        stack.push(OperatorNode.new(token, lhs, rhs).evaluate)
      else
        fail "Unknown token #{token.inspect}"
      end
    end
    stack.pop.to_postfix
  end
end

p Expression.new("0 x +").evaluate


# tree = OperatorNode.new("*")

# tree.left = OperatorNode.new("+")
# tree.left.left = NumericNode.new(5)
# tree.left.right = NumericNode.new(4)

# value = tree.left
# left = tree.left.left
# right = tree.left.right

# tree.right = OperatorNode.new("+")
# tree.right.left = NumericNode.new(6)
# tree.right.right = NumericNode.new(7)

#         *
#       /   \
#      +     +
#     / \   / \
#    5   4 6   7

# class NumericNode < ExpressionNode; end
# class VariableNode < ExpressionNode; end
