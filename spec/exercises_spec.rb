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
  describe '.ex4' do
    it 'returns the max number of the array' do
      array = Exercises.ex4([1,2,3])
      expect(array).to eq(3)
    end
  end
  describe '.ex5' do
    xit 'puts each element of an array' do
      Exercises.should_receive(:puts).with(/"a"\n"b"\n"c"/)
      Exercises.ex5([2])
      # /1\n2\n3/
    end
  end
  describe '.ex6' do
    it 'updates last item in array to "panda"' do
      array = Exercises.ex6([1,2,3])
      expect(array).to eq([1,2,3,"panda"]) #should this update to panda or add panda?
    end
   it 'updates last item in array to "GODZILLA" if the last item is "panda"' do
      array = Exercises.ex6([1,2,3,"panda"])
      expect(array).to eq([1,2,3,"GODZILLA"])
    end
  end
  describe '.ex7' do
    it 'if "str" exists in an array, add "str" to the end of the array' do
      array = Exercises.ex7([1,2,"hello",3], "hello" )
      expect(array).to eq([1,2,3,"hello"])
    end
  end
  describe '.ex8' do
    xit 'print the key value pairs of each hash in the array' do
      array = Exercises.ex8([{:name => "Buddy", :occupation => "Plumber"}, {:name => "Tricia", :ocupation => "CEO"}])
      expect(array).to eq()
    end
  end
end
