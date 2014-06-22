require 'spec_helper'
require 'pry-byebug'

describe 'ORM' do

  before(:all) do
    TM.orm.instance_variable_set(:@db_adaptor, PG.connect(host: 'localhost', dbname: 'task-manager-db-test'))
  end

  before(:each) do
    TM.orm.reset_tables
  end

  after(:all) do
    TM.orm.drop_tables
  end

  it "is an ORM" do
    expect(TM.orm).to be_a(TM::ORM)
  end

  it 'is created with a db adaptor' do
    expect(TM.orm.db_adaptor).not_to be_nil
  end

  describe '#add_project' do
    it 'adds the project to the database and returns an array with project information' do
      expect(TM.orm.add_project("happy")).to be_a(Array)
    end
  end

  describe '#list_projects' do
    it 'lists all the projects in the database' do
      TM.orm.add_project("code")
      TM.orm.add_project("homework")

      expect(TM.orm.list_projects).to be_a(Array)
      expect(TM.orm.list_projects.size).to eq(2)
      expect(TM.orm.list_projects[0][0]).to eq("code")
    end
  end

  # describe '#get' do
  #   xit 'lists a single project by project_id and returns as Project instance' do
  #     TM.orm.add_project("code")

  #     project1 = TM.orm.get(1)

  #     expect(project1).to be_a(TM::Project)
  #     expect(project1.name).to eq("code")
  #   end
  # end

  describe '#create_task' do
    it 'creates a task and adds to the database' do
      TM.orm.add_project("code")

      expect(TM.orm.create_task(3,"task1",1)[0]).to eq("1")
      expect(TM.orm.create_task(3,"task1",1)).to be_a(Array)
    end
  end

  # describe '#delete_task'do
  #   xit 'deletes a task by task_id' do
  #     project1 = TM.orm.add_project("code")
  #     TM.orm.create_task(3,"task1",1)

  #     expect(TM.orm.delete_task(1)).to be_a(TM::Task)

  #     # expect(TM.orm.delete_task(1).complete).to eq("f")
  #   end
  # end

  describe '#task_list' do
    it 'lists all the tasks in the database' do
      TM.orm.add_project("code")

      TM.orm.create_task(3,"task1",1)
      TM.orm.create_task(3,"task2",1)
      TM.orm.create_task(3,"task3",1)

      expect(TM.orm.task_list(1)).to be_a(Array)
      expect(TM.orm.task_list(1).size).to eq(3)
    end
  end

  describe '#mark' do
    it 'marks a task as complete' do
      TM.orm.add_project("code")

      TM.orm.create_task(3,"task1",1)

      expect(TM.orm.mark(1,1)).to eq(true)
    end
  end

  describe '#retrieve_completed_tasks_for_project' do
    it 'lists all the completed tasks in the database' do
      TM.orm.add_project("code")
      TM.orm.add_project("code")

      TM.orm.create_task(3,"task1",1)
      TM.orm.create_task(3,"task2",2)

      TM.orm.mark(1,1)

      expect(TM.orm.retrieve_completed_tasks_for_project(1)).to be_a(Array)
      expect(TM.orm.retrieve_completed_tasks_for_project(1).size).to eq(1)
    end
  end

  describe '#retrieve_incomplete_tasks_for_project' do
    it 'lists all the incomplete tasks in the database' do
      TM.orm.add_project("code")

      TM.orm.create_task(3,"task1",1)
      TM.orm.create_task(3,"task2",1)

      expect(TM.orm.retrieve_incomplete_tasks_for_project(1)).to be_a(Array)
      expect(TM.orm.retrieve_incomplete_tasks_for_project(1).size).to eq(2)
    end
  end

  describe '#create_employee' do
    it 'adds the employee to the database and returns an array with the employee id and employee name' do
      employee = TM.orm.create_employee("smith")
      expect(employee).to be_a(Array)
    end
  end

  describe '#list_all_employees' do
    it 'lists all the employees in the database and returns an array with the employee information' do
      employee = TM.orm.create_employee("smith")
      employee = TM.orm.create_employee("darwin")
      employee = TM.orm.create_employee("fred")

      expect(TM.orm.list_all_employees).to be_a(Array)
      expect(TM.orm.list_all_employees.size).to eq(3)
    end
  end

  describe '#add_employee_to_project' do
    it 'adds the employee to the database' do
      TM.orm.create_employee("smith")
      TM.orm.add_project("code")

      expect(TM.orm.add_employee_to_project(1,1)).to eq(true)
    end
  end

  describe '#show_employee_projects' do
    it 'uses an eid to return an array of project information for a specific employee' do
      TM.orm.create_employee("smith")

      TM.orm.add_project("code")
      TM.orm.add_project("hello_world")

      TM.orm.add_employee_to_project(1,1)
      TM.orm.add_employee_to_project(2,1)

      expect(TM.orm.show_employee_projects(1)).to be_a(Array)
    end
  end

  describe '#show_employees_in_project' do
    it 'shows all employees in a specific project (on PID) and returns an array of project information' do
      TM.orm.add_project("code")

      TM.orm.create_employee("smith")
      TM.orm.create_employee("ben")
      TM.orm.create_employee("wahoo")

      TM.orm.add_employee_to_project(1,1) #pid,eid
      TM.orm.add_employee_to_project(1,2)
      TM.orm.add_employee_to_project(1,3)

      expect(TM.orm.show_employees_in_project(1)).to be_a(Array)
      expect(TM.orm.show_employees_in_project(1).size).to eq(3)
    end
  end


  describe '#assign_task_to_employee' do
    it 'assigns a task to an employee and returns true' do
      TM.orm.create_employee("smith")
      TM.orm.add_project("code")

      TM.orm.add_employee_to_project(1,1)

      TM.orm.create_task(3,"task1",1)

      expect(TM.orm.assign_task_to_employee(1,1)).to eq(true)
    end
  end


  describe '#employee_incomplete_tasks' do
    it 'shows incomplete tasks for the employee, along with project name next to task' do
      TM.orm.add_project("code")

      TM.orm.create_employee("smith")

      TM.orm.add_employee_to_project(1,1)

      TM.orm.create_task(3,"task1",1)
      TM.orm.create_task(2,"task2",1)
      TM.orm.create_task(5,"task3",1)

      TM.orm.assign_task_to_employee(1,1)
      TM.orm.assign_task_to_employee(2,1)
      TM.orm.assign_task_to_employee(3,1)

      TM.orm.mark(1,1)

      # binding.pry

      expect(TM.orm.employee_incomplete_tasks(1)).to be_a(Array)
      expect(TM.orm.employee_incomplete_tasks(1).size).to eq(2)
    end
  end


  describe '#employee_completed_tasks' do
    xit 'takes an employee id and shows completed tasks for employees' do
      TM.orm.add_project("code")

      TM.orm.create_task(3,"task1",1)
      TM.orm.create_task(3,"task2",2)
      TM.orm.create_task(3,"task3",1)

      TM.orm.assign_task_to_employee(1,1)
      TM.orm.assign_task_to_employee(2,1)
      TM.orm.assign_task_to_employee(3,1)

      TM.orm.mark(1,1)

      expect(TM.orm.employee_completed_tasks(1)).to be_a(Array)
      expect(TM.orm.employee_completed_tasks(1).size).to eq(1)
    end
  end

end
