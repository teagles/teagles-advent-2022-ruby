# frozen_string_literal: true

require 'pry-byebug'

module Year2022
  class Day08 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file
    def self.point(x_pos, y_pos)
      { 'x' => x_pos, 'y' => y_pos }
    end

    EAST = Day08.point(1, 0)
    SOUTH = Day08.point(0, 1)
    WEST = Day08.point(-1, 0)
    NORTH = Day08.point(0, -1)

    def part_1
      min_x = 0
      max_x = data.first.length - 1
      min_y = 0
      max_y = data.length - 1
      (check_direction(data, Day08.point(min_x, min_y), EAST, SOUTH) |
        check_direction(data, Day08.point(max_x, min_y), SOUTH, WEST) |
        check_direction(data, Day08.point(max_x, max_y), WEST, NORTH) |
        check_direction(data, Day08.point(min_x, max_y), NORTH, EAST)).length
    end

    def check_direction(grid, starting_point, length_increment, depth_increment)
      current_point = starting_point
      visible_points = Set.new
      while in_range(current_point, grid)
        # binding.pry
        length_start = current_point
        visible_height = -1
        while in_range(current_point, grid)
          # binding.pry
          break if visible_height == 9

          tree = lookup(grid, current_point)
          visible_points << current_point if tree > visible_height
          visible_height = [tree, visible_height].max
          current_point = increment_point(current_point, depth_increment)
        end
        current_point = increment_point(length_start, length_increment)
      end
      visible_points
    end

    def in_range(point, grid)
      point['x'] >= 0 && point['x'] < grid.first.length && point['y'] >= 0 && point['y'] < grid.length
    end

    def increment_point(point, increment)
      { 'x' => point['x'] + increment['x'], 'y' => point['y'] + increment['y'] }
    end

    def lookup(grid, point)
      # puts point
      grid[point['y']][point['x']]
    end

    def part_2
      nil
    end

    # Processes each line of the input file and stores the result in the dataset
    def process_input(line)
      line.chars.map(&:to_i)
    end

    # Processes the dataset as a whole
    # def process_dataset(set)
    #   set
    # end
  end
end
