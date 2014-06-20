require 'spec_helper'


describe 'TM::Task' do
  xit "exists" do
    expect(TM::Task).to be_a(Class)
  end

  describe '#initialize' do

    xit 'has a name and id' do

      employee1 = TM::Employee.new(1, "smith")
      expect(employee1.name).to eq("smith")
      expect(employee.id).to eq(1)
    end
  end
end
