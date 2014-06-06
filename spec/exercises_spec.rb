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


end
