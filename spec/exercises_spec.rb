require 'rubygems'
require_relative '../exercises.rb'

describe Exercises do
  describe '.ex0' do
    context 'str is wishes' do
      it 'Triples a str' do
        res = Exercises.ex0("hi")
        expect(res).to eq("hihihi")
      end
    end
    context 'str is "wishes"' do
      it 'returns "nope"' do
        res = Exercises.ex0("wishes")
        expect(res).to eq("nope")
      end
    end
  end
  describe '.ex1' do
    it 'returns the number of elements in array' do
      array = Exercises.ex1([1,2,3])
      expect(array).to eq(3)
    end
  end
  describe '.ex2' do
    it 'returns the second element of array' do
      array = Exercises.ex2([1,2,3])
      expect(array).to eq(2)
    end
  end
  describe '.ex3' do
    it 'returns the sum of numbers in the array' do
      array = Exercises.ex3([1,2,3])
      expect(array).to eq(6)
    end
  end
  # describe '.ex4' do
  #   it 'returns the max number of the array' do
  #     array = Exercises.ex4([1,2,3])
  #     expect(array).to eq(3)
  #   end
  # end
end
