require 'pg'
require 'pry-byebug'

module TM
  class ORM
    # @db.create_task(data)
    # @db.get_task(id)
    # @db.update_task(id, data)
    # @db.delete_task(id)

    attr_reader :db_adaptor
    def initialize
      @db_adaptor = PG.connect(host: 'localhost', dbname: 'task-manager-db')
    end

    def create_tables
      command = <<-SQL
      CREATE TABLE IF NOT EXISTS employees(
        id SERIAL,
        name text,
        PRIMARY KEY (id)
        );
      CREATE TABLE IF NOT EXISTS projects(
        name text,
        id SERIAL PRIMARY KEY,
        EID integer REFERENCES employees(id)
        );
      CREATE TABLE IF NOT EXISTS tasks(
        id SERIAL PRIMARY KEY,
        priority_number INTEGER,
        description TEXT,
        creation_date date,
        complete BOOLEAN,
        PID INTEGER REFERENCES projects(id)
        );
      CREATE TABLE IF NOT EXISTS joins_projects_employees(
        id SERIAL,
        PID INTEGER REFERENCES projects(id),
        EID INTEGER REFERENCES employees(id)
        );
      CREATE TABLE IF NOT EXISTS joins_tasks_employees(
        id SERIAL,
        TID INTEGER REFERENCES tasks(id),
        EID INTEGER REFERENCES employees(id)
        );
      SQL

      @db_adaptor.exec(command)
    end

    def drop_tables
      command = <<-SQL
        DROP TABLE IF EXISTS projects CASCADE;
        DROP TABLE IF EXISTS tasks CASCADE;
        DROP TABLE IF EXISTS employees CASCADE;
        DROP TABLE IF EXISTS joins_projects_employees CASCADE;
        DROP TABLE IF EXISTS joins_projects_employees CASCADE;
      SQL

      @db_adaptor.exec(command)
    end

    def reset_tables
      drop_tables
      create_tables
    end

    def add_project(name)
      command = <<-SQL
        INSERT INTO projects(name)
        VALUES('#{name}')
        RETURNING *;
      SQL
      result = @db_adaptor.exec(command).values.first
      TM::Project.new(result[0], result[1])
    end

    def list_projects
      command = <<-SQL
        SELECT * FROM projects;
      SQL
      result = @db_adaptor.exec(command).values

      projects = []

      result.each do |project|
        projects << TM::Project.new(project[0], project[1])
      end

      projects
    end


    def create_task(priority_number, description, pid) #creates a new task
      creation_date = Time.now
      complete = false
      command = <<-SQL
        INSERT INTO tasks (priority_number,description,creation_date,complete, pid)
        VALUES('#{priority_number}', '#{description}', '#{creation_date}', '#{complete}', '#{pid}')
        RETURNING *;
      SQL

      result = @db_adaptor.exec(command).values[0]

      TM::Task.new(result[0], result[1], result[2], result[3], result[4],result[5])
    end

    def get(id) #gets the project we want
      command = <<-SQL
        SELECT name
        FROM projects
        WHERE id = ('#{id}');
      SQL

      result = @db_adaptor.exec(command).values[0][0]

      puts "Found #{result}"
    end

    def task_list(pid) #lists all tasks for a specific project
      command = <<-SQL
        SELECT * FROM tasks
        WHERE pid = ('#{pid}');
      SQL

      result = @db_adaptor.exec(command).values
      # binding.pry

      tasks =[]

      result.each do |task|
        tasks << TM::Task.new(task[0].to_i, task[1].to_i,task[2],task[3],task[4],task[5].to_i) #convert to integer, convert to date
      end

      tasks

    end

    def complete(pid) #lists completed tasks for a specific project
      command = <<-SQL
        SELECT *
        FROM tasks
        WHERE pid = ('#{pid}') AND complete = true;
      SQL

      result = @db_adaptor.exec(command).values

      tasks_complete = []

      result.each do |task|
        tasks_complete << TM::Task.new(task[0], task[1],task[2],task[3],task[4],task[5])
      end

      tasks_complete
    end

    def mark(tid) #mark a task complete
      command = <<-SQL
      UPDATE tasks
      SET complete = true
      WHERE id = ('#{tid}')
      RETURNING *;
      SQL

      result = @db_adaptor.exec(command).values.first

      TM::Task.new(result[0], result[1], result[2], result[3], result[4],result[5])


        #do this in task class?
    end

    def incomplete(pid) #lists incomplete tasks for a specific project
      command = <<-SQL
      SELECT complete = false,
      FROM tasks
      WHERE PID = ('#{pid}');
      SQL

      result = @db_adaptor.exec(command).values

      tasks_incomplete = []

      result.each do |task|
        tasks_incomplete << TM::Task.new(task[0], task[1])
      end

      task
    end


  end

  def self.orm
   @__orm_instance ||= ORM.new
  end

end

