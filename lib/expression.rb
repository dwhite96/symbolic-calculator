require "binary_tree"

class UndefinedVariableError < StandardError; end

class Expression < BinaryTree

  # Returns a new expression
  def initialize(expr)
    @expr = expr
  end

  # Evaluates an expression, simplifying if possible.
  #
  # @param bindings [Hash] a map of variable names to concrete values
  # @return [Expression] Returns a possibly-simplified Expression
  def evaluate(bindings = {})
    stack = []
    @expr.split.each do |token|
      case token
      when /\A\d+\z/
        number = Number.new(token)
        stack.push(number)
      when "+"
        right = stack.pop(1)
        left = stack.pop(1)
        value.add(left, right)
      end
    end
    stack.pop
  end

end
