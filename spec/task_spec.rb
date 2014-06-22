require 'spec_helper'
require 'pry-byebug'
require 'date'
require 'time'



describe 'TM::Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  describe '#initialize' do

    it "has a creation date" do
      project1 = TM::Project.add_project("code")
      task1 = project1.create_task(2,"task1",1)

      expect(task1.creation_date).should be_an_instance_of(DateTime)
    end

    it "has a priority number" do
      project1 = TM::Project.add_project("code")
      task1 = project1.create_task(2,"task1",1)

      expect(task1.priority_number).to eq(2)
    end

    it "complete is false" do
      project1 = TM::Project.add_project("code")
      task1 = project1.create_task(2,"task1",1)

      expect(task1.complete).to eq(false)
    end
  end


  describe "#mark_complete" do
    it "will mark a task as complete" do
      project1 = TM::Project.add_project("code")
      task1 = project1.create_task(2,"task1",1)

      expect(task1.mark_complete).to eq(true)
    end
  end

end
