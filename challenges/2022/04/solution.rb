# frozen_string_literal: true

require 'pry'

module Year2022
  class Day04 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    def part_1
      tally = 0
      data.each do |range_pair|
        tally += 1 if (range_pair.first - range_pair.last).empty? || (range_pair.last - range_pair.first).empty?
      end
      tally
    end

    def part_2
      tally = 0
      data.each do |range_pair|
        tally += 1 if range_pair.first.intersect?(range_pair.last)
      end
      tally
    end

    # Processes each line of the input file and stores the result in the dataset
    def process_input(line)
      line.split(',').map { |rs| rs.split('-').map(&:to_i) }.map { |r| Range.new(*r).to_set }
    end

    # Processes the dataset as a whole
    # def process_dataset(set)
    #   set
    # end
  end
end
