class Player
  COORDINATES = {
    :a => 0,
    :b => 1,
    :c => 2,
    :d => 3,
    :e => 4,
    :f => 5,
    :g => 6,
    :h => 7
  }

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def get_input
    puts "#{color.capitalize} move."
    gets.chomp
  end

  def take_turn
    Player.process_input(get_input)
  end

  private
  def self.validate_input(input)

    if input.flatten.any? { |pos| !pos.between?(0, 7) }
      raise
    elsif input.flatten.length != 4
      raise
    end

    input
  end

  def self.process_input(input)
    from, to = input.split
    begin
      from_x = COORDINATES[from[0].to_sym]
      from_y = 8 - from[1].to_i

      to_x = COORDINATES[to[0].to_sym]
      to_y = 8 - to[1].to_i

      Player.validate_input([[from_y, from_x], [to_y, to_x]])
    rescue
      raise InvalidInputError, "Invalid input."
    end
  end

end
