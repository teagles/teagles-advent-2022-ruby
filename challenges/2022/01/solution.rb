# frozen_string_literal: true

module Year2022
  class Day01 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    def part_1
      data.map(&:sum).max
    end

    def part_2
      data.map(&:sum).sort.last(3).sum
    end

    # Processes each line of the input file and stores the result in the dataset
    def process_input(line)
      line.to_i
    end

    # Processes the dataset as a whole
    def process_dataset(set)
      results = []
      current_elf = []
      set.each do |food_item|
        if food_item.zero?
          results << current_elf
          current_elf = []
        else
          current_elf << food_item
        end
      end
      results << current_elf unless current_elf.none?
    end
  end
end
