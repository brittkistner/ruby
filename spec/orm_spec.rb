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
    it 'adds the project to the database and returns a Project instance' do
      expect(TM.orm.add_project("happy")).to be_a(TM::Project)
    end
  end

  describe '#list_projects' do
    it 'lists all the projects in the database as Project instances' do
      project1 = TM.orm.add_project("code")
      project2 = TM.orm.add_project("homework")

      expect(TM.orm.list_projects.map{|proj| proj.name}).to include("code", "homework")

      # expect(TM.orm.list_projects[0].created_at).to eq(project1.created_at)
    end
  end

  describe '#get' do
    it 'lists a single project by project_id and returns as Project instance' do
      TM.orm.add_project("code")

      project1 = TM.orm.get(1)

      expect(project1).to be_a(TM::Project)
      expect(project1.name).to eq("code")
    end
  end

  describe '#create_task' do
    it 'creates a task and adds to the database and returns a Task instance' do
      project1 = TM.orm.add_project("code")
      expect(TM.orm.create_task(3,"what",1)).to be_a(TM::Task)
    end
  end

  describe '#delete_task'do
    it 'deletes a task by task_id' do
      project1 = TM.orm.add_project("code")
      TM.orm.create_task(3,"task1",1)

      expect(TM.orm.delete_task(1)).to be_a(TM::Task)

      # expect(TM.orm.delete_task(1).complete).to eq("f")
    end
  end

  describe '#task_list' do
    it 'lists all the tasks in the database as Task instances' do
      project1 = TM.orm.add_project("code")

      TM.orm.create_task(3,"task1",1)
      TM.orm.create_task(3,"task2",1)
      TM.orm.create_task(3,"task3",1)

      expect(TM.orm.task_list(1).map{|task| task.project_id}).to include(1,1,1)
    end
  end

  describe '#mark' do
    it 'marks a task as complete' do
      project1 = TM.orm.add_project("code")

      TM.orm.create_task(3,"task1",1)

      result = TM.orm.mark(1,1)

      expect(result).to be_a(TM::Task)
      expect(result.complete).to eq("t") #change to boolean
    end
  end

  describe '#complete' do
    it 'lists all the completed tasks in the database as Task instances' do
      project1 = TM.orm.add_project("code")
      project2 = TM.orm.add_project("code")

      TM.orm.create_task(3,"task1",1)
      TM.orm.create_task(3,"task2",2)
      TM.orm.create_task(3,"task3",1)

      TM.orm.mark(1,1)

      expect(TM.orm.complete(1)).to be_a(Array)
      expect(TM.orm.complete(1).map{|task| task.project_id}).to include(1)
    end
  end

  describe '#incomplete' do
    it 'lists all the incomplete tasks in the database as Task instances' do
      project1 = TM.orm.add_project("code")

      TM.orm.create_task(3,"task1",1)
      TM.orm.create_task(3,"task2",1)
      TM.orm.create_task(3,"task3",1)

      expect(TM.orm.complete(1)).to be_a(Array)
      expect(TM.orm.incomplete(1).map{|task| task.project_id}).to include(1,1,1)
    end
  end

  describe '#create_employee' do
    it 'adds the employee to the database and returns an Employee instance' do
      expect(TM.orm.create_employee("smith")).to be_a(TM::Employee)
    end
  end

  describe '#list_all_employees' do
    it 'lists all the employees in the database and returns as Employee instances' do
      expect(TM.orm.create_employee("smith")).to be_a(TM::Employee)
      expect(TM.orm.create_employee("ben")).to be_a(TM::Employee)
      expect(TM.orm.create_employee("wahoo")).to be_a(TM::Employee)

      expect(TM.orm.list_all_employees.map{|employee| employee.name}).to include("smith", "ben", "wahoo")
    end
  end

  describe '#add_employee_to_project' do
    xit 'adds the employee to the database' do
      TM.orm.create_employee("smith")
      TM.orm.add_project("code")

      expect(TM.orm.add_employee_to_project(1,1)).to eq(true)
    end
  end

  describe '#show_employee_projects' do
    xit 'lists employees by eid and all of their participating projects and returns as Employee instances' do
      TM.orm.create_employee("smith")
      TM.orm.create_employee("ben")


      TM.orm.add_project("code")
      TM.orm.add_project("hello_world")

      TM.orm.add_employee_to_project(1,1)
      TM.orm.add_employee_to_project(2,2)

      expect(TM.orm.show_employee_projects(2)).to be_a(Array)
    end
  end

  describe '#show_employees_in_project' do
    xit 'shows all employees in a specific project' do
      TM.orm.add_project("code")

      TM.orm.create_employee("smith")
      TM.orm.create_employee("ben")
      TM.orm.create_employee("wahoo")

      TM.orm.add_employee_to_project(1,1) #pid,eid
      TM.orm.add_employee_to_project(1,2)
      TM.orm.add_employee_to_project(1,3)


      expect(TM.orm.show_employees_in_project(1).map{|task| employee.name}).to include("smith", "ben", "wahoo")
    end
  end


  describe '#assign_task_to_employee' do
    xit 'adds the employee to the database and returns an Employee instance' do
      project1 = TM.orm.add_project("code")

      TM.orm.create_task(3,"task1",1)

      TM.orm.create_employee("smith")

      task = TM.orm.assign_task_to_employee(1,1) #tid,eid

      binding.pry

      # expect(task).to be_a(Array) #what should this return

    end
  end


  describe '#employee_tasks' do
    xit 'shows incomplete tasks for the employee, along with project name next to task' do
      project1 = TM.orm.add_project("code")
      project2 = TM.orm.add_project("code")

      TM.orm.create_task(3,"task1",1)
      TM.orm.create_task(3,"task2",2)
      TM.orm.create_task(3,"task3",1)

      TM.orm.create_employee("smith")
      TM.orm.create_employee("ben")

      TM.orm.assign_task_to_employee(1,1) #tid,eid
      TM.orm.assign_task_to_employee(2,1)

      TM.orm.mark(1,1) #tid,pid => marking task1 complete

      # binding.pry

      expect(TM.orm.employee_tasks(1)).to be_a(Array)

    end
  end


  describe '#employee_completed_tasks' do
    xit 'takes an employee id and shows completed tasks for employees' do

      project1 = TM.orm.add_project("code")
      project2 = TM.orm.add_project("code")

      TM.orm.create_task(3,"task1",1)
      TM.orm.create_task(3,"task2",2)
      TM.orm.create_task(3,"task3",1)

      TM.orm.assign_task_to_employee(1,1) #tid,eid

      TM.orm.mark(1,1)

      completed_tasks = TM.orm.employee_completed_tasks(1)

      expect(completed_tasks).to be_a(Array)
      expect(completed_tasks.map{|task| task.description}).to include("task1")
    end
  end

end
