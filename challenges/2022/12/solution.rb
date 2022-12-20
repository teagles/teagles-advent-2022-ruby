# frozen_string_literal: true

require 'pry-byebug'

module Year2022
  class Day12 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file
    Point = Struct.new(:x, :y)
    Map = Struct.new(:elevations, :start, :finish)
    DIRECTIONS = { U: Point.new(0, 1).freeze,
                   D: Point.new(0, -1).freeze,
                   L: Point.new(-1, 0).freeze,
                   R: Point.new(1, 0).freeze }.freeze

    def part_1
      map = data
      # binding.pry
      recurse({ map.start => [map.start] }, Set[map.start], map).length - 1
    end

    def recurse(paths, seen, map)
      # binding.pry
      loop do
        next_paths = {}
        goal = paths.keys.select { |p| p == map.finish }
        return paths[goal.first] unless goal.empty?

        paths.each_key do |p|
          possible_next_steps(p, map).reject { |p_2| seen.include? p_2 }.each do |new_point|
            seen << new_point
            next_paths[new_point] = paths[p] + [new_point]
          end
        end
        paths = next_paths
        # binding.pry
      end
      nil
    end

    def possible_next_steps(point, map)
      permute_directions(point).filter do |p|
        direction_elevation = get_elevation(map, p)
        if direction_elevation.nil?
          false
        else
          direction_elevation <= (get_elevation(map, point) + 1)
        end
      end
    end

    def permute_directions(point)
      DIRECTIONS.map { |_key, value| Point.new(point.x + value.x, point.y + value.y) }
    end

    def get_elevation(map, point)
      map.elevations[point.x][point.y]
    rescue StandardError
      nil
    end

    def part_2
      nil
    end

    # Processes each line of the input file and stores the result in the dataset
    # def process_input(line)
    #   line.map(&:to_i)
    # end

    # Processes the dataset as a whole
    def process_dataset(set)
      result = Map.new(nil, nil, nil)
      # binding.pry
      result.elevations = process_elevations(set, result).map { |col| col.map(&:freeze).freeze }
      result
    end

    def process_elevations(set, map)
      set.map(&:chars).reverse.transpose.each_with_index.map do |sub, x|
        sub.each_with_index.map do |char, y|
          case char
          when 'S'
            map.start = Point.new(x, y).freeze
            elevint 'a'
          when 'E'
            map.finish = Point.new(x, y).freeze
            elevint 'z'
          else
            elevint char
          end
        end
      end
    end

    def elevint(char)
      char.ord - 'a'.ord
    end
  end
end
