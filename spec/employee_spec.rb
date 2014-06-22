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
    xit 'lists all employees and returns an array of Employee instances' do
      employee1 = TM::Employee.add_employee("smith")
      employee1 = TM::Employee.add_employee("darwin")
      employee1 = TM::Employee.add_employee("fred")

      expect(TM::Employee.list_employees).to be_a(Array)
      expect(TM::Employee.list_employees[0]).to be_a(TM::Employee)
      expect(TM::Employee.list_employees.size).to eq(3)
    end
  end

  describe '#assign_task_to_employee(tid,eid)' do
    xit 'assigns a task (TID) to an employee with EID and returns either true or false' do
      employee1 = TM::Employee.new(1, "smith")


    end
  end

  describe '.self.show_employee_projects' do
    xit 'returns an array of all projects an employee with EID is working on' do
    #this should return an employee name and return an array of projects (and id) for all employee projects

    end
  end

  describe '.incomplete_tasks' do
    xit 'shows all incomplete tasks for employee with an EID and returns an array of incompleted tasks' do
    end
  end

  describe '.complete_tasks' do
    xit 'shows all complete tasks for employee with an EID and returns an array of completed tasks' do
    end
  end
end
