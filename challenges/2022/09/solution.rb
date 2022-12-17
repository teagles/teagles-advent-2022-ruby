# frozen_string_literal: true

require 'pry-byebug'

module Year2022
  class Day09 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file
    INPUT_MATCHER = /([LRUD]) (\d+)/
    Move = Struct.new(:direction, :distance)
    Point = Struct.new(:x, :y)
    RopePair = Struct.new(:head, :tail)
    Ropel = Struct.new(:knots, :visited)
    DIRECTIONS = { U: Point.new(0, 1).freeze,
                   D: Point.new(0, -1).freeze,
                   L: Point.new(-1, 0).freeze,
                   R: Point.new(1, 0).freeze }.freeze

    def part_1
      rope = Ropel.new([Point.new(0, 0), Point.new(0, 0)], Set[Point.new(0, 0)])
      data.each do |move|
        apply_move(rope, move)
      end
      rope.visited.length
    end

    def apply_move(rope, move)
      Range.new(1, move.distance).each do |_step|
        move_points(rope, move.direction)
      end
    end

    # def move_pair(pair, direction)
    #   pair.head = move_point(pair.head, direction)
    #   pair.tail = move_tail(pair)
    #   pair.visited << pair.tail
    # end

    def move_points(ropel, direction)
      ropel.knots[0] = move_point(ropel.knots.first, direction)
      Range.new(1, ropel.knots.length - 1).each do |index|
        ropel.knots[index] = move_tail(ropel.knots[index - 1], ropel.knots[index])
      end
      ropel.visited << ropel.knots.last
    end

    def move_tail(head, tail)
      diff = diff_point(head, tail)
      if diff.x.abs <= 1 && diff.y.abs <= 1
        tail
      elsif diff.x.zero?
        move_point(tail, Point.new(0, diff.y / diff.y.abs))
      elsif diff.y.zero?
        move_point(tail, Point.new(diff.x / diff.x.abs, 0))
      else
        move_point(tail, Point.new(diff.x / diff.x.abs, diff.y / diff.y.abs))
      end
    end

    def diff_point(point_a, point_b)
      Point.new(point_a.x - point_b.x, point_a.y - point_b.y)
    end

    def move_point(point, direction)
      Point.new(point.x + direction.x, point.y + direction.y)
    end

    def part_2
      rope = Ropel.new(Array.new(10) { Point.new(0, 0) }, Set[Point.new(0, 0)])
      data.each do |move|
        apply_move(rope, move)
      end
      rope.visited.length
    end

    # Processes each line of the input file and stores the result in the dataset
    def process_input(line)
      parsed = line.match(INPUT_MATCHER)
      Move.new(DIRECTIONS[parsed[1].to_sym], parsed[2].to_i)
    end

    # Processes the dataset as a whole
    # def process_dataset(set)
    #   set
    # end
  end
end
