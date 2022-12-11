# frozen_string_literal: true

require 'pry-byebug'

module Year2022
  class Day07 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    INSTRUCTION_MATCHER = %r{\$ (cd |ls)(/|\.\.|\S+)?}
    RESPONSE_MATCHER = /(dir|\d+) (\S+)/

    class Instruction
      attr_reader :command, :argument

      def initialize(matches)
        @command = matches[1]
        @argument = matches[2]
      end

      def ls?
        @argument.nil?
      end
    end

    class Response
      attr_reader :name, :size

      def initialize(matches)
        @name = matches[2]
        return if matches[1] == 'dir'

        @size = matches[1].to_i
      end

      def dir?
        @size.nil?
      end
    end

    def part_1
      calculate_sizes(data).filter { |_path, size| size <= 100_000 }.map { |_path, size| size }.sum
    end

    def calculate_sizes(dirs)
      sizes = {}
      dirs.to_a.each do |path, _content|
        size_of(path, dirs, sizes) unless sizes[path]
      end
      sizes
    end

    def size_of(dir, dirs, sizes)
      total_size = 0
      dirs[dir].each do |_name, value|
        total_size += if value.instance_of?(Integer)
                        value
                      else
                        size_of(value, dirs, sizes)
                      end
      end
      sizes[dir] = total_size
    end

    def part_2
      sizes = calculate_sizes(data)
      used = sizes[['/']]
      free = 70_000_000 - used
      needed = 30_000_000 - free
      sizes.map { |_path, size| size }.filter { |size| size >= needed }.min
    end

    # Processes each line of the input file and stores the result in the dataset
    def process_input(line)
      instruction = line.match INSTRUCTION_MATCHER
      if instruction
        Instruction.new(instruction)
      else
        Response.new(line.match RESPONSE_MATCHER)
      end
    end

    # Processes the dataset as a whole
    def process_dataset(set)
      directories = Hash.new { |hash, key| hash[key] = {} }
      cwd = nil
      set.each do |line|
        if line.instance_of?(Instruction)
          cwd = handle_instruction(cwd, line)
        else
          directories[cwd.dup][line.name] = if line.dir?
                                              cwd + [line.name]
                                            else
                                              line.size
                                            end
        end
      end
      directories
    end

    def handle_instruction(cwd, line)
      unless line.ls?
        case line.argument
        when '..'
          cwd.pop
        when '/'
          cwd = ['/']
        else
          cwd.push line.argument
        end
      end
      cwd
    end
  end
end
