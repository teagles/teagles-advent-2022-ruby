# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2022::Day08 do
  let(:input) { File.read(File.join(File.dirname(__FILE__), '../../../challenges/2022/08/input.txt')) }
  let(:example_input) do
    <<~EXAMPLE_INPUT
      30373
      25512
      65332
      33549
      35390
    EXAMPLE_INPUT
  end

  describe 'part 1' do
    it 'returns 21 for the example input' do
      expect(described_class.part_1(example_input)).to eq(21)
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
