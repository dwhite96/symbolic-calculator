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
        else
          stack.push(token.to_s)
        end
      when /\d+/
        stack.push(token.to_i)
      when "+", "-", "*", "/"
        operands = stack.pop(2)
        if operands.all? { |i| i.to_s.match(/\d+/) } == true
          stack.push(operands[0].send(token, operands[1]))
        elsif operands.any? { |i| i == 0 } == true
          if token == "*"
            stack.push(0)
          else token == "+" || "-"
            operands = operands - [0]
            stack.push(operands)
          end
        else
          stack.push(operands[0], operands[1], token)
        end
      end
    end
    stack.join(" ")
  end
end
