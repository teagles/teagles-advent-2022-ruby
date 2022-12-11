# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2022::Day06 do
  let(:input) { File.read(File.join(File.dirname(__FILE__), '../../../challenges/2022/06/input.txt')) }
  let(:example_input_1) do
    <<~EXAMPLE_INPUT
      mjqjpqmgbljsphdztnvjfqwrcgsmlb
    EXAMPLE_INPUT
  end

  let(:example_input_2) do
    <<~EXAMPLE_INPUT
      bvwbjplbgvbhsrlpgdmjqwftvncz
    EXAMPLE_INPUT
  end

  let(:example_input_3) do
    <<~EXAMPLE_INPUT
      nppdvjthqldpwncqszvftbrmjlhg
    EXAMPLE_INPUT
  end

  let(:example_input_4) do
    <<~EXAMPLE_INPUT
      nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg
    EXAMPLE_INPUT
  end

  let(:example_input_5) do
    <<~EXAMPLE_INPUT
      zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw
    EXAMPLE_INPUT
  end

  describe 'part 1' do
    it 'returns 7 for the example_1 input' do
      expect(described_class.part_1(example_input_1)).to eq(7)
    end

    it 'returns 5 for the example_2 input' do
      expect(described_class.part_2(example_input_1)).to eq(5)
    end

    it 'returns 6 for the example_3 input' do
      expect(described_class.part_3(example_input_1)).to eq(6)
    end

    it 'returns 10 for the example_4 input' do
      expect(described_class.part_4(example_input_1)).to eq(10)
    end

    it 'returns 11 for the example_5 input' do
      expect(described_class.part_5(example_input_1)).to eq(11)
    end

    it 'returns nil for my input' do
      expect(described_class.part_1(input)).to eq(nil)
    end
  end

  describe 'part 2' do
    it 'returns nil for the example input' do
      expect(described_class.part_2(example_input)).to eq(nil)
    end

    it 'returns nil for my input' do
      expect(described_class.part_2(input)).to eq(nil)
    end
  end
end
