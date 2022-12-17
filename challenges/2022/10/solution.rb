# frozen_string_literal: true

require 'pry-byebug'

module Year2022
  class Day10 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file
    INPUT_MATCHER = /(noop|addx)( -?\d+)?/
    Instruction = Struct.new(:instruction, :argument)
    SINGNIFICANT_CYCLES = Set[20, 60, 100, 140, 180, 220].freeze
    ArithmeticLogicReplacement = Struct.new(:register, :cycle_num, :sum_of_signals)

    def part_1
      alr = ArithmeticLogicReplacement.new(1, 0, 0)
      process_data alr
    end

    def process_data(alr)
      data.each do |instruction|
        case instruction.instruction
        when :addx
          addx(alr, instruction.argument)
        when :noop
          noop(alr)
        end
      end
      raise 'Out of Input'
    rescue StandardError
      alr.sum_of_signals
    end

    def addx(alr, argument)
      process_cycle(alr)
      process_cycle(alr)
      alr.register += argument
    end

    def noop(alr)
      process_cycle(alr)
    end

    def process_cycle(alr)
      alr.cycle_num += 1
      if alr.sum_of_signals.instance_of?(Integer)
        alr.sum_of_signals += alr.cycle_num * alr.register if SINGNIFICANT_CYCLES.include? alr.cycle_num
        raise 'DONE' if alr.cycle_num == SINGNIFICANT_CYCLES.max
      else
        # binding.pry
        y_pos = (alr.cycle_num - 1) / 40
        x_pos = (alr.cycle_num - 1) % 40
        sprite_range = Range.new(alr.register - 1, alr.register + 1)
        alr.sum_of_signals[y_pos][x_pos] = -'#' if sprite_range.cover?(x_pos)
      end
    end

    def part_2
      alr = ArithmeticLogicReplacement.new(1, 0, Array.new(6) { Array.new(40) { -'.' } })
      (process_data alr).map(&:join).join(-"\n") + -"\n"
    end

    # Processes each line of the input file and stores the result in the dataset
    def process_input(line)
      lexed = line.match(INPUT_MATCHER)
      Instruction.new(lexed[1].to_sym, lexed[2].nil? ? nil : lexed[2].to_i)
    end

    # Processes the dataset as a whole
    # def process_dataset(set)
    #   set
    # end
  end
end
