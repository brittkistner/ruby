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

  end

  describe '#create_task' do
    it 'creates a task and adds to the database and returns a Task instance' do
      project1 = TM.orm.add_project("code")
      expect(TM.orm.create_task(3,"what",1)).to be_a(TM::Task)
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

  describe '#complete' do
    xit 'lists all the completed tasks in the database as Task instances' do
      project1 = TM.orm.add_project("code")
      project2 = TM.orm.add_project("code")

      TM.orm.create_task(3,"task1",1)
      TM.orm.create_task(3,"task2",2)
      TM.orm.create_task(3,"task3",1)

      TM.orm.mark(3)

      expect(TM.orm.complete(1).project_id).to eq(1)
    end
  end

  describe '#mark' do
    it 'marks a task as complete' do
      project1 = TM.orm.add_project("code")

      TM.orm.create_task(3,"task1",1)

      expect(TM.orm.mark(1).complete).to eq("t") #change to boolean
    end
  end

  describe '#incomplete' do
    xit 'lists all the completed tasks in the database as Task instances' do
      project1 = TM.orm.add_project("code")

      TM.orm.create_task(3,"task1",1)
      TM.orm.create_task(3,"task2",1)
      TM.orm.create_task(3,"task3",1)
    end
  end

end
