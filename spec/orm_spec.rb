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

      # binding.pry

      expect(TM.orm.list_projects.map{|proj| proj.name}).to include("code", "homework")

      # expect(TM.orm.list_projects[0].created_at).to eq(project1.created_at)
    end
  end

  describe '#create_task' do
    it 'creates a task and adds to the database and returns a Task instance' do
      project1 = TM.orm.add_project("code")
      expect(TM.orm.create_task(3,"what",1)).to be_a(TM::Task)
      binding.pry
    end
  end

  describe '#get' do

  end

  describe '#task_list' do
  end

  describe '#complete' do
  end

  describe '#mark' do
  end

  describe '#incomplete' do
  end

end
