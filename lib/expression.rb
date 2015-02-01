class UndefinedVariableError < StandardError; end

class Expression < Base

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
        number = Number.new(token.to_i)
        stack.push(number)
      when "+", "-", "*", "/"
        left = stack.pop(1)
        right = stack.pop(1)
        if "+"
          value.add(left, right)
        end
      end
    end
    stack.pop
  end

end
