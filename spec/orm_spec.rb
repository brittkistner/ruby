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

  describe '#create_employees' do
    it 'adds the employee to the database and returns an Employee instance' do
      expect(TM.orm.create_employees()).to be_a(TM::Employee)
    end
  end

  describe '#list_employees' do
    it 'lists all the employees in the database and returns as Employee instances' do
      expect(TM.orm.list_employees()).to be_a(TM::Employee)

    end
  end

  describe '#show_employees' do
    it 'lists employees by eid and all of their participating projects and returns as Employee instances' do
      expect(TM.orm.show_employees()).to be_a(TM::Employee)

    end
  end

  describe '#show_employees_in_project' do
    it 'adds the employee to the database and returns an Employee instance' do
      #TO DO
    end
  end


  describe '#add_employee_to_project' do
    it 'adds the employee to the database and returns an Employee instance' do
    end
  end


  describe '#assign_task_to_employee' do
    it 'adds the employee to the database and returns an Employee instance' do
    end
  end


  describe '#employee_tasks' do
    it 'shows incomplete tasks for the employee, along with project name next to task' do
    end
  end


  describe '#employee_completed_tasks' do
    it 'shows completed tasks for employees' do
    end
  end

end
