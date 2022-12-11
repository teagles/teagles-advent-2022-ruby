# frozen_string_literal: true

module Year2022
  class Day06 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    def part_1
      first_unique(data, 4)
    end

    def part_2
      first_unique(data, 14)
    end

    def first_unique(chars, length)
      last_n = []
      chars.chars.each_with_index do |c, i|
        last_n << c
        last_n = last_n.last length
        return (i + 1) if last_n.to_set.length == length
      end
    end

    # Processes each line of the input file and stores the result in the dataset
    # def process_input(line)
    #   line.map(&:to_i)
    # end

    # Processes the dataset as a whole
    # def process_dataset(set)
    #   set
    # end
  end
end
