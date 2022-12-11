# frozen_string_literal: true

require 'pry-byebug'

module Year2022
  class Day06 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    def part_1
      last_4 = []
      data.chars.each_with_index do |c, i|
        # binding.pry
        last_4 << c
        last_4 = last_4.last 4
        return (i + 1) if last_4.to_set.length == 4
      end
    end

    def part_2
      nil
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
