class UndefinedVariableError < StandardError; end

class Expression

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
      when /[a-z]+/
        token = token.to_sym
        if bindings.include?(token)
          stack.push(bindings[token])
        end
      when /\d/
        stack.push(token.to_i)
      when "+", "-", "*", "/"
        operands = stack.pop(2)
        stack.push(operands[0].send(token, operands[1]))
      end
    end
    stack.pop
  end
end
