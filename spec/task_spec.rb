require 'spec_helper'
require 'pry-byebug'


describe 'TM::Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  describe '#initialize' do

    #let bang?
    xit "has a creation date" do
      project1 = TM.orm.add_project("project1")
      task1 = project1.create_task(2,"task1",1)

      expect(task1.creation_date).to be_a(date) #check for date
    end

    it "has a priority number" do
      project1 = TM.orm.add_project("project1")
      task1 = project1.create_task(2,"task1",1)

      expect(task1.priority_number).to eq(2)
    end

    xit "complete is false" do
      project1 = TM.orm.add_project("project1")
      task1 = project1.create_task(2,"task1",1)
      # record[‘column’] == “true”

      expect(task1.complete).to eq("f")
    end
  end


  describe "#mark_complete" do
    xit "will mark a task as complete" do
      task1 = TM::Task.new(3,"task1",5, "description", 3, 5)
      expect(task1.mark_complete).to eq(true)
    end
  end

end
