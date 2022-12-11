# frozen_string_literal: true

module Year2022
  class Day05 < Solution
    BOX_PATTERN = /(?:\[| )([A-Z ])(?:\]| )(?: |$)/
    MOVE_PATTERN = /^move ([0-9]+) from ([0-9]+) to ([0-9]+)$/

    class Move
      attr_reader :quantity, :source, :destination

      def initialize(quantity, source, destination)
        @quantity = quantity
        @source = source
        @destination = destination
      end

      def do_on(boxes, crate_mover_9001: false)
        crane = boxes[@source - 1].slice!(0, @quantity)
        boxes[@destination - 1].unshift(*(crate_mover_9001 ? crane : crane.reverse))
      end
    end

    class Data
      attr_reader :boxes, :moves

      def initialize(boxes, moves)
        @boxes = boxes
        @moves = moves
      end
    end

    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    def part_1
      data.moves.map { |m| m.do_on(data.boxes) }
      data.boxes.map(&:first).join
    end

    def part_2
      data.moves.map { |m| m.do_on(data.boxes, crate_mover_9001: true) }
      data.boxes.map(&:first).join
    end

    # Processes each line of the input file and stores the result in the dataset
    # def process_input(line)
    #   binding.pry
    # end

    # Processes the dataset as a whole
    def process_dataset(set)
      boxes = []
      moves = []
      box_mode = true
      set.each do |line|
        if box_mode
          box_mode = process_boxes(line, boxes)
        else
          process_move(line, moves)
        end
      end
      Data.new(boxes.transpose.map { |pile| pile.reject { |b| b == ' ' } }, moves)
    end

    def process_boxes(line, boxes)
      m = line.scan(BOX_PATTERN)
      return false if m.empty?

      boxes << m.map(&:first)

      true
    end

    def process_move(line, moves)
      m = line.match(MOVE_PATTERN)
      moves << Move.new(m[1].to_i, m[2].to_i, m[3].to_i) if m
    end
  end
end
