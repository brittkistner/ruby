require 'spec_helper'
require 'pry-byebug'

describe 'TM::Project' do

  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  describe '.add_project' do
    it 'creates a new project instance' do
      expect(TM::Project.add_project("project1")).to be_a(TM::Project)
    end
  end

  describe '.get' do
    it 'gets the id of a project and creates a new project instance' do
      TM::Project.add_project("code")
      expect(TM::Project.get(1)).to be_a(TM::Project)
    end
  end

  describe '.list_projects' do
    it 'returns an array of all projects in the database' do
      TM::Project.add_project("code")
      TM::Project.add_project("homework")

      expect(TM::Project.list_projects.map{|proj| proj.name}).to include("code", "homework")
    end
  end

  describe "#initialize" do
    it 'create a name and id' do
      project1 = TM::Project.new("project1",1)

      expect(project1.name).to eq("project1")
      expect(project1.id).to eq(1)
    end
  end

  describe "#create_task" do
    it 'new task created' do
      project1 = TM::Project.add_project("project1")

      task1 = project1.create_task(2,"task1")
      expect(task1).to be_a(TM::Task)

      task2 = project1.create_task(4,"task2")
      expect(task2).to be_a(TM::Task)
    end
  end

  describe "#task_list" do
    it'returns an array of all tasks in a project given the PID' do
      project1 = TM::Project.add_project("project1")

      project1.create_task(2,"task1")
      project1.create_task(4,"task2")

      expect(project1.task_list).to be_a(Array)
      expect(project1.task_list[0]).to be_a(TM::Task)
      expect(project1.task_list.size).to eq(2)
    end
  end


  describe '#project_mark_complete and #retrieve_completed_tasks' do  #TEST FOR ORDER OF RETURN
    it 'mark a task as completed by TID and PID and return a list of completed Task intances' do
      project1 = TM::Project.add_project("project1")

      task1 = project1.create_task(2,"task1")

      task1.mark_complete

      task_complete = project1.retrieve_completed_tasks

      expect(task_complete.map {|task| task.description}).to include("task1")
      expect(task_complete[0]).to be_a(TM::Task)

    end
  end

  describe "#retrieve_incomplete_tasks" do #TEST FOR ORDER OF RETURN
    it 'returns an array of Task instances which are incomplete' do
      project1 = TM::Project.add_project("project1")

      project1.create_task(5,"task1")
      task2 = project1.create_task(4,"task2")
      project1.create_task(1,"task3")

      task2.mark_complete

      task_incomplete = project1.retrieve_incomplete_tasks

      expect(task_incomplete.size).to eq(2)
      expect(task_incomplete.map {|task| task.description}).to include("task1","task3")
      expect(task_incomplete[0]).to be_a(TM::Task)
    end
  end

  describe '#show_employees_in_project' do
    it 'returns an array of employee instances from a project given the PID' do
      project1 = TM::Project.add_project("project1")

      TM::Employee.add_employee('Sara')
      TM::Employee.add_employee('Paul')

      project1.add_employee_to_project(1)
      project1.add_employee_to_project(2)

      expect(project1.show_employees_in_project).to be_a(Array)
      expect(project1.show_employees_in_project[0]).to be_a(TM::Employee)
    end
  end

  describe '#add_employee_to_project' do
    it 'adds an employee to a project (given an EID and project id) and returns true if the employee is successfully added' do
      project1 = TM::Project.add_project("project1")

      TM::Employee.add_employee('Sara')

      expect(project1.add_employee_to_project(1)).to eq(true)
    end
  end

  describe '#delete_task' do
    it 'deletes a task given a task id and project id and returns true' do
      project1 = TM::Project.add_project("project1")
      project1.create_task(5,"task1")

      project1.delete_task(1)
    end
  end

end



