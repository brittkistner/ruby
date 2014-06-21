require 'spec_helper'
require 'pry-byebug'

describe 'TM::Project' do

  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  describe "#initialize" do
    it 'create a name and id' do
      project1 = TM.orm.add_project("project1")

      expect(project1.name).to eq("project1")
      expect(project1.id).to eq(1)
    end
  end

  describe "#create_task" do
    it 'new task created' do
      project1 = TM.orm.add_project("project1")

      task1 = project1.create_task(2,"task1",1)
      expect(task1).to be_a(TM::Task)

      task2 = project1.create_task(4,"task2",1)
      expect(task2).to be_a(TM::Task)
    end
  end

  describe '#mark_complete and #retrieve_completed_tasks' do
    it 'mark a task as completed by id and return a list of completed tasks' do
      project1 = TM.orm.add_project("project1")

      project1.create_task(2,"task1", 1)

      #check task is false?

      task1 = project1.project_mark_complete(1)

      expect(task1).to be_a(TM::Task)
      expect(task1.complete).to eq("t")

      task_complete = project1.retrieve_completed_tasks

      expect(task_complete.map {|task| task.description}).to include("task1")
    end
  end

  describe "#retrieve_incomplete_tasks" do
    it 'by priority number then creation date' do
      project1 = TM.orm.add_project("project1")

      project1.create_task(5,"task1",1)
      project1.create_task(4,"task2",1)
      project1.create_task(1,"task3",1)

      task1 = project1.project_mark_complete(2)

      task_incomplete = project1.retrieve_incomplete_tasks
      expect(task_incomplete.size).to eq(2)
      expect(task_incomplete.map {|task| task.description}).to include("task1","task3")
    end
  end

end



