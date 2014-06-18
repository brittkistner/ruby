require 'spec_helper'


describe 'TM::Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  describe '#initialize' do

    before do
      @task1 = TM::Task.new(3,"task1",5, "description", 3, 5)
    end

    it "has a name" do
      expect(@task1.name).to eq("task1")
    end

    it "has a creation date" do
      # allow(@task1).to receive(:creation_date).and_return("3:00")
      expect(@task1.creation_date).to eq(3)
    end

    it "has a priority number" do
      expect(@task1.priority_number).to eq(5)
    end

    it "initially incomplete" do
      expect(@task1.complete).to eq(false)
    end
  end

  describe "#priority_number" do
    it "will return nil if the priority number is not inclusive of 1..5" do
      task1 = TM::Task.new(3,"task1",6, "description", 3, 5)
      expect(task1.priority_number).to eq(5)
    end
  end

  describe "#mark_complete" do
    it "will mark a task as complete" do
      task1 = TM::Task.new(3,"task1",5, "description", 3, 5)
      expect(task1.mark_complete).to eq(true)
    end
  end

end
