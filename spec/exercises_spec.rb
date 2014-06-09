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
    # it 'puts each element of an array' do
    #   Exercises.ex5([1,2,3,4])
    #   Exercises.should_receive(:puts).and_return("1\n2\n3\n4\n")
    # end
    before do #http://stackoverflow.com/questions/17711744/rspec-puts-output-test
      $stdout = StringIO.new
    end

    after(:all) do
      $stdout = STDOUT
    end

    it "puts each element" do
      Exercises.ex5([1,2,3,4])
      expect($stdout.string).to match("1\n2\n3\n4\n")
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
  describe '.ex9' do
    it 'returns true if the given time is in a leap year' do
      leap_year = Exercises.ex9(2016) #Time.now??
      expect(leap_year).to eq(true)
    end
    it 'returns false if not a leap year' do
      leap_year = Exercises.ex9(2015)
      expect(leap_year).to eq(false)
    end
  end
end
