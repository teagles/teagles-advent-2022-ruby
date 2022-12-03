# frozen_string_literal: true

module Year2022
  class Day03 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    def part_1
      problem_items = determine_problem_items data
      problem_items.map { |char| score char }.sum
    end

    def determine_problem_items(lines)
      lines.map do |line|
        (line.slice(0, line.length / 2).chars.to_set & line.slice(line.length / 2,
                                                                  line.length / 2).chars.to_set).first
      end
    end

    def part_2
      data.each_slice(3).map { |g| score(g.map { |e| e.chars.to_set }.reduce(:&).first) }.sum
    end

    def score(char)
      if /[[:upper:]]/.match(char)
        char.ord - 'A'.ord + 27
      else
        char.ord - 'a'.ord + 1
      end
    end
  end
end
