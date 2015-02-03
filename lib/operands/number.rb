require "expression"

class Number < Expression

  def initialize(number)
    @number = number.to_i
  end

end
