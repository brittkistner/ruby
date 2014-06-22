require 'spec_helper'


describe 'TM::Employee' do
  it "exists" do
    expect(TM::Employee).to be_a(Class)
  end

  describe '#initialize' do

    it 'has a name and id' do
      employee1 = TM::Employee.new(1, "smith")
      expect(employee1.name).to eq("smith")
      expect(employee1.id).to eq(1)
    end
  end

  describe '.add_employee' do
    it 'creates an employee and returns an Employee instance' do
      expect(TM::Employee.add_employee("smith")).to be_a(TM::Employee)
    end
  end


  describe '.list_employees' do
    it 'lists all employees and returns an array of Employee instances' do
      employee1 = TM::Employee.add_employee("smith")
      employee1 = TM::Employee.add_employee("darwin")
      employee1 = TM::Employee.add_employee("fred")

      expect(TM::Employee.list_employees).to be_a(Array)
      expect(TM::Employee.list_employees[0]).to be_a(TM::Employee)
      expect(TM::Employee.list_employees.size).to eq(3)
    end
  end

  describe '#assign_task_to_employee' do
    it 'assigns a task (TID) to an employee with EID and returns either true or false' do
      employee1 = TM::Employee.add_employee("smith")
      project1 = TM::Project.add_project("project1")

      project1.create_task(2,"task1",1)

      expect(employee1.assign_task_to_employee(1,1)).to eq(true)
    end
  end

  describe '.self.show_employee_projects' do
    it 'returns an array of all projects an employee with EID is working on' do
    #this should return an employee name and return an array of projects (and id) for all employee projects
      project1 = TM::Project.add_project("code")
      project1 = TM::Project.add_project("homework")

      TM::Employee.add_employee("smith")
      TM::Project.add_employee_to_project(1,1)
      TM::Project.add_employee_to_project(2,1)

      expect(TM::Employee.show_employee_projects(1).map{|project| project.name}).to include("code","homework")
      expect(TM::Employee.show_employee_projects(1)[0]).to be_a(TM::Project)
    end
  end

  describe '.incomplete_tasks' do
    xit 'shows all incomplete tasks for employee with an EID and returns an array of incompleted tasks' do
      employee1 = TM::Employee.add_employee("smith")

      project1 = TM::Project.add_project("project1")

      project1.create_task(2,"task1",1)
      project1.create_task(4,"task2",1)

      employee1.assign_task_to_employee(1,1)
      employee1.assign_task_to_employee(2,1)

      expect(employee1.incomplete_tasks(1)).to be_a(Array)
      expect(employee1.incomplete_tasks(1)[0]).to be_a(TM::Task)
      expect(employee1.incomplete_tasks(1).size).to eq(2)
    end
  end

  describe '.complete_tasks' do
    it 'shows all complete tasks for employee with an EID and returns an array of completed tasks' do
      employee1 = TM::Employee.add_employee("smith")

      project1 = TM::Project.add_project("project1")

      project1.create_task(2,"task1",1)
      project1.create_task(4,"task2",1)
      project1.create_task(1,"task3",1)

      employee1.assign_task_to_employee(1,1)
      employee1.assign_task_to_employee(2,1)
      employee1.assign_task_to_employee(3,1)

      project1.project_mark_complete(1,1)
      project1.project_mark_complete(2,1)

      expect(TM::Employee.complete_tasks(1)).to be_a(Array)
      expect(TM::Employee.complete_tasks(1)[0]).to be_a(TM::Task)
      expect(TM::Employee.complete_tasks(1).size).to eq(2)
    end
  end
end
