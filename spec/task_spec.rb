require 'spec_helper'


describe 'TM::Task' do
  xit "exists" do
    expect(TM::Task).to be_a(Class)
  end

  describe '#initialize' do

    before do
      @task1 = TM::Task.new(3, 5, "description")
    end

    xit "has a creation date" do
      allow(@task1).to receive(:creation_date).and_return("3:00")
      expect(@task1.creation_date).to eq("3:00")
    end

    xit "has a priority number" do
      expect(@task1.priority_number).to eq(3)
    end

    xit "@complete is false" do
      allow(@task1).to receive(:complete).and_return(false)
      expect(@task1.complete).to eq(false)
    end
  end

  describe "#priority_number" do
    xit "will return nil if the priority number is not inclusive of 1..5" do
      task1 = TM::Task.new(3,"task1",6, "description", 3, 5)
      expect(task1.priority_number).to eq(3)
    end
  end

  describe "#mark_complete" do
    xit "will mark a task as complete" do
      task1 = TM::Task.new(3,"task1",5, "description", 3, 5)
      expect(task1.mark_complete).to eq(true)
    end
  end

end
