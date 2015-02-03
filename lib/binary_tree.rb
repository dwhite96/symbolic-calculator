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

def BinaryTree(value)
  case value
  when BinaryTree
    value
  else
    BinaryTree.new(value)
  end
end

class BinaryTree
  attr_accessor :value, :left, :right

  def initialize(value = nil, left = nil, right = nil)
    @value = value
    @left = left
    @right = right
  end

end
