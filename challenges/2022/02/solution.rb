# frozen_string_literal: true

module Year2022
  class Day02 < Solution
    SCORE_HASH = {
      X: { base_score: 1, match_score: {
        A: 3,
        B: 0,
        C: 6
      }.freeze },
      Y: { base_score: 2, match_score: {
        A: 6,
        B: 3,
        C: 0
      }.freeze },
      Z: { base_score: 3, match_score: {
        A: 0,
        B: 6,
        C: 3
      }.freeze }
    }.freeze

    SCORE_HASH_2 = {
      X: { base_score: 0, match_score: {
        A: 3,
        B: 1,
        C: 2
      }.freeze },
      Y: { base_score: 3, match_score: {
        A: 1,
        B: 2,
        C: 3
      }.freeze },
      Z: { base_score: 6, match_score: {
        A: 2,
        B: 3,
        C: 1
      }.freeze }
    }.freeze
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    def part_1
      score(data, SCORE_HASH)
    end

    def part_2
      score(data, SCORE_HASH_2)
    end

    def score(tokens, crib)
      tokens.map do |token|
        match = crib[token.last]
        match[:base_score] + match[:match_score][token.first]
      end.sum
    end

    # Processes each line of the input file and stores the result in the dataset
    def process_input(line)
      line.split.map(&:to_sym)
    end

    # Processes the dataset as a whole
    def process_dataset(set)
      set
    end
  end
end
