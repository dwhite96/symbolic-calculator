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
        # Convert variable to integer value if included in bindings hash
        if bindings.include?(token)
          stack.push(bindings[token])
        else
          stack.push(token.to_s)
        end
      when /\d+/
        stack.push(token.to_i)
      when "+", "-", "*", "/"
        operands = stack.pop(2)
        # Perform arithmetic operation if both operands are integers
        if operands.all? { |i| i.to_s.match(/\d+/) }
          stack.push(operands[0].send(token, operands[1]))
        # Handle zeros correctly
        elsif operands.any? { |i| i == 0 }
          if token == "*"
            stack.push(0)
          elsif token == "+"
            operands.delete(0)
            stack.push(operands[0])
          else token == "-"
            if operands[0] == 0
              operands.delete(0)
              stack.push("-" + operands[0])
            else operands[1] == 0
              operands.delete(0)
              stack.push(operands[0])
            end
          end
        # Push algebraic expression onto stack
        else
          stack.push(operands[0], operands[1], token)
        end
      end
    end
    stack.join(" ")
  end
end
