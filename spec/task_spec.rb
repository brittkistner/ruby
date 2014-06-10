require 'spec_helper'

describe 'Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  context 'when initialized' do
    # before(:each) do
    #   task1 = TM::Task.new("task1",5)
    # end
    it "has a name" do
      task1 = TM::Task.new("task1",5)
      expect(task1.name).to eq("task1")
    end

    it "has a creation date" do
      task1 = TM::Task.new("task1",5)
    end

    it "has a priority number" do
      task1 = TM::Task.new("task1",5)
      expect(task1.priority_number).to eq(5)
    end

    it "has a status of available" do
      task1 = TM::Task.new("task1",5)
      expect(task1.status).to eq("available")
    end

    it "will return a nil description if nothing provided" do
      task1 = TM::Task.new("task1",5)
      expect(task1.description).to eq(nil)
    end

    xit "will return nil if the priority number is not inclusive of 1..5" do
      task1 = TM::Task.new("task1",6)
      expect(task1.priority_number).to eq(nil)
    end
  end
end
