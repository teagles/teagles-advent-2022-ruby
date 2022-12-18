# frozen_string_literal: true

require 'pry-byebug'

module Year2022
  class Day11 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file
    MONKEY_MATCHER = /(Monkey \d+:.*?If false: throw to monkey \d+\n)+/m
    MONKEY_NUM_MATCHER = /Monkey (\d+):/
    STARTING_ITEMS_MATCHER = /Starting items: (.*)\n/
    OPERATION_MATCHER = /Operation: new = (old|\d+) (\+|\*) (old|\d+)\n/
    TEST_MATCHER = /Test: divisible by (\d+)\n/
    TRUE_CASE_MATCHER = /If true: throw to monkey (\d+)\n/
    FALSE_CASE_MATCHER = /If false: throw to monkey (\d+)\n/
    Operation = Struct.new(:first_term, :operation, :second_term)
    Monkey = Struct.new(:items, :operation, :test, :true_case, :false_case, :examination_score)

    def part_1
      monkeys = describe_monkeys
      (1..20).each do |_round|
        monkeys.each_key do |key|
          process_monkey(monkeys, monkeys[key])
        end
      end
      monkeys.map { |_key, monkey| monkey.examination_score }.sort.last(2).reduce(:*)
    end

    def process_monkey(monkeys, monkey)
      monkey.items.each do |item|
        process_item(monkeys, monkey, item)
      end
      monkey.items = []
    end

    def process_item(monkeys, monkey, item)
      monkey.examination_score += 1
      worry = process_worry(item, monkey.operation) / 3
      if (worry % monkey.test).zero?
        monkeys[monkey.true_case].items << worry
      else
        monkeys[monkey.false_case].items << worry
      end
    end

    def process_worry(worry, operation)
      first = operation.first_term.instance_of?(Symbol) ? worry : operation.first_term
      second = operation.second_term.instance_of?(Symbol) ? worry : operation.second_term
      first.send(operation.operation, second)
    end

    def part_2
      nil
    end

    def describe_monkeys
      monkeys = {}
      matches = @input.scan(MONKEY_MATCHER)
      matches.map(&:first).each do |monkey_str|
        index = monkey_str.match(MONKEY_NUM_MATCHER)[1].to_i
        items = monkey_str.match(STARTING_ITEMS_MATCHER)[1].split(', ').map(&:to_i)
        operation_tokens = monkey_str.match(OPERATION_MATCHER)
        first_term = parse_term(operation_tokens[1])
        second_term = parse_term(operation_tokens[3])
        operation = Operation.new(first_term, operation_tokens[2].to_sym, second_term)
        test_int = monkey_str.match(TEST_MATCHER)[1].to_i
        true_case = monkey_str.match(TRUE_CASE_MATCHER)[1].to_i
        false_case = monkey_str.match(FALSE_CASE_MATCHER)[1].to_i
        monkeys[index] = Monkey.new(items, operation, test_int, true_case, false_case, 0)
      end
      monkeys
    end

    def parse_term(term)
      Integer(term)
    rescue StandardError
      :old
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
