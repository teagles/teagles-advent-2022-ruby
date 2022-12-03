# frozen_string_literal: true

require 'pry'

module Year2022
  class Day03 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    def part_1
      data.map { |char| score char }.sum
    end

    def part_2
      nil
    end

    def score(char)
      if /[[:upper:]]/.match(char)
        char.ord - 'A'.ord + 27
      else
        char.ord - 'a'.ord + 1
      end
    end

    # Processes each line of the input file and stores the result in the dataset
    def process_input(line)
      (line.slice(0,
                  line.length / 2).chars.to_set & line.slice(line.length / 2,
                                                             line.length / 2).chars.to_set).first
    end

    # Processes the dataset as a whole
    def process_dataset(set)
      set
    end
  end
end
