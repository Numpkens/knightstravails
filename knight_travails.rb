class KnightMoves
  MOVES = [
    [-2, -1], [-2, 1], [-1, -2], [-1, 2],
    [1, -2], [1, 2], [2, -1], [2, 1]
  ].freeze

  def initialize
    @board_size = 8
  end

  def knight_moves(start_pos, end_pos)
    # Return immediately if start and end positions are the same
    return [start_pos] if start_pos == end_pos

    # Initialize queue with start position and empty path
    queue = [[start_pos, [start_pos]]]
    visited = Set.new([start_pos])

    while !queue.empty?
      current_pos, path = queue.shift

      # Get all possible moves from current position
      possible_moves(current_pos).each do |next_pos|
        next if visited.include?(next_pos)

        new_path = path + [next_pos]

        # If we've reached the target position, return the path
        if next_pos == end_pos
          print_solution(new_path)
          return new_path
        end

        # Add the new position to visited set and queue
        visited.add(next_pos)
        queue.push([next_pos, new_path])
      end
    end
  end

  private

  def possible_moves(pos)
    x, y = pos
    MOVES.map { |dx, dy| [x + dx, y + dy] }
         .select { |new_x, new_y| valid_position?([new_x, new_y]) }
  end

  def valid_position?(pos)
    x, y = pos
    x.between?(0, @board_size - 1) && y.between?(0, @board_size - 1)
  end

  def print_solution(path)
    puts "You made it in #{path.length - 1} moves! Here's your path:"
    path.each { |pos| puts pos.inspect }
  end
end

# Example usage:
knight = KnightMoves.new

# Test cases
knight.knight_moves([0,0], [1,2])
puts "\n"
knight.knight_moves([0,0], [3,3])
puts "\n"
knight.knight_moves([3,3], [0,0])
puts "\n"
knight.knight_moves([0,0], [7,7])
