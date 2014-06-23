require 'spec_helper'


describe 'TM::Employee' do
  it "exists" do
    expect(TM::Employee).to be_a(Class)
  end

  describe '.get' do
    it 'gets the id of an employee and creates a new Employee instance' do
      TM::Employee.add_employee('Suzie')
      expect(TM::Employee.get(1)).to be_a(TM::Employee)
    end
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
      binding.pry
      expect(TM::Employee.add_employee("smith")).to be_a(TM::Employee)
    end
  end


  describe '.list_employees' do
    it 'lists all employees and returns an array of Employee instances' do
      TM::Employee.add_employee("smith")
      TM::Employee.add_employee("darwin")
      TM::Employee.add_employee("fred")

      expect(TM::Employee.list_employees).to be_a(Array)
      expect(TM::Employee.list_employees[0]).to be_a(TM::Employee)
      expect(TM::Employee.list_employees.size).to eq(3)
    end
  end

  describe '#assign_task_to_employee' do
    it 'assigns a task (TID) to an employee with EID and returns either true or false' do
      employee1 = TM::Employee.add_employee("smith")
      project1 = TM::Project.add_project("project1")

      project1.create_task(2,"task1")

      expect(employee1.assign_task_to_employee(1)).to eq(true)
    end
  end

  describe '.self.show_employee_projects' do
    it 'returns an array of all projects an employee with EID is working on' do
    #this should return an employee name and return an array of projects (and id) for all employee projects
      project1 = TM::Project.add_project("code")
      project2 = TM::Project.add_project("homework")

      employee = TM::Employee.add_employee("smith")
      project1.add_employee_to_project(1)
      project2.add_employee_to_project(1)

      expect(employee.show_employee_projects.map{|project| project.name}).to include("code","homework")
      expect(employee.show_employee_projects[0]).to be_a(TM::Project)
    end
  end

  describe '#incomplete_tasks' do
    it 'shows all incomplete tasks for employee with an EID and returns an array of incompleted tasks' do
      employee = TM::Employee.add_employee("smith")

      project1 = TM::Project.add_project("project1")

      project1.create_task(2,"task1")
      project1.create_task(4,"task2")

      employee.assign_task_to_employee(1)
      employee.assign_task_to_employee(2)

      expect(employee.incomplete_tasks).to be_a(Array)
      expect(employee.incomplete_tasks[0]).to be_a(TM::Task)
      expect(employee.incomplete_tasks.size).to eq(2)
    end
  end

  describe '#complete_tasks' do
    it 'shows all complete tasks for employee with an EID and returns an array of completed tasks' do
      employee = TM::Employee.add_employee("smith")

      project1 = TM::Project.add_project("project1")

      task1 = project1.create_task(2,"task1")
      task2 = project1.create_task(4,"task2")
      project1.create_task(1,"task3")

      employee.assign_task_to_employee(1)
      employee.assign_task_to_employee(2)
      employee.assign_task_to_employee(3)

      task1.mark_complete
      task2.mark_complete

      expect(employee.complete_tasks).to be_a(Array)
      expect(employee.complete_tasks[0]).to be_a(TM::Task)
      expect(employee.complete_tasks.size).to eq(2)
    end
  end
end
