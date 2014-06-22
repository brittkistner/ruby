require 'pg'
require 'pry-byebug'

module TM
  class ORM

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
        EID INTEGER REFERENCES employees(id)
        );
      CREATE TABLE IF NOT EXISTS tasks(
        id SERIAL PRIMARY KEY,
        priority_number INTEGER,
        description TEXT,
        creation_date date,
        complete BOOLEAN,
        PID INTEGER REFERENCES projects(id),
        EID INTEGER REFERENCES employees(id)
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
      @db_adaptor.exec(command).values.first
      #return an array
      # TM::Project.new(result[0], result[1].to_i)
    end

    def list_projects
      command = <<-SQL
        SELECT * FROM projects;
      SQL

      @db_adaptor.exec(command).values
    end


    def create_task(priority_number, description, pid)
      creation_date = Time.now
      complete = false
      command = <<-SQL
        INSERT INTO tasks (priority_number,description,creation_date,complete, pid)
        VALUES('#{priority_number}', '#{description}', '#{creation_date}', '#{complete}', '#{pid}')
        RETURNING *;
      SQL

      result = @db_adaptor.exec(command).values[0]
    end



    def task_list(pid) #lists all tasks for a specific project
      command = <<-SQL
        SELECT * FROM tasks
        WHERE pid = ('#{pid}');
      SQL

      result = @db_adaptor.exec(command).values

      result #returns an array of strings of tasks
    end

    def mark(tid,pid) #mark a task complete and returns true or false
      command = <<-SQL
      UPDATE tasks
      SET complete = true
      WHERE id = ('#{tid}') AND pid = ('#{pid}');
      SQL

      @db_adaptor.exec(command).values.first

      true
    end

    def retrieve_completed_tasks_for_project(pid) #lists completed tasks for a specific project
      command = <<-SQL
        SELECT *
        FROM tasks
        WHERE pid = ('#{pid}') AND complete = true
        ORDER BY priority_number, creation_date;
      SQL

      result = @db_adaptor.exec(command).values

      result
    end

    def retrieve_incomplete_tasks_for_project(pid) #lists incomplete tasks for a specific project
      command = <<-SQL
      SELECT *
      FROM tasks
      WHERE pid = ('#{pid}') AND complete = false
      ORDER BY priority_number, creation_date;
      SQL

      result = @db_adaptor.exec(command).values

      result
    end

    def create_employee(name)
      command = <<-SQL
        INSERT INTO employees(name)
        VALUES('#{name}')
        RETURNING *;
      SQL

      result = @db_adaptor.exec(command).values.first
    end

    def list_all_employees
      command = <<-SQL
        SELECT * FROM employees
      SQL

      @db_adaptor.exec(command).values #returns an array
    end

    def add_employee_to_project(pid,eid) #Adds employee EID to participate in project PID
      command = <<-SQL
      INSERT INTO joins_projects_employees
      (pid, eid)
      VALUES
      (pid,eid);
      SQL

      result = @db_adaptor.exec(command).values

      true
    end

    def show_employee_projects(eid) #list employee by eid and all of their participating projects
      command = <<-SQL
      SELECT p.eid, p.name
      FROM joins_projects_employees AS pe
      JOIN projects AS p
      ON pe.PID = p.id
      WHERE pe.eid = '#{eid}';
      SQL

      result = @db_adaptor.exec(command).values

      #returns as an array with eid and name (how should I return it)
      #call this in the employee class and return list of projects
      #convert to an array of objects

    end

    def show_employees_in_project(pid) #project employees PID' - Show employees participating in this project
      command = <<-SQL
      SELECT e.id, e.name
      FROM joins_projects_employees AS pe
      JOIN employees AS e
      ON pe.EID = e.id
      WHERE pe.pid = '#{pid}';
      SQL

      @db_adaptor.exec(command).values
      #returns an array with infor about the employee name(s) and id(s)
    end

    def assign_task_to_employee(tid,eid) #task assign TID EID' - Assign task to employee
      command = <<-SQL
      INSERT INTO joins_tasks_employees (tid,eid)
      VALUES ('#{tid}', '#{eid}');
      SQL

      true
    end

    def employee_incomplete_tasks(eid) #show incomplete tasks for the employee, along with project name next to task
      command = <<-SQL
      SELECT t.id, t.priority_number, t.description, t.creation_date, t.complete, t.pid, p.name
      FROM joins_tasks_employees AS te
      JOIN tasks AS t
      ON te.tid = t.id
      JOIN projects AS p
      ON t.pid = pid
      WHERE te.eid = '#{eid}' AND t.complete = false;
      SQL

      @db_adaptor.exec(command).values #returns an array
    end

    def employee_completed_tasks(eid) #show completed tasks for employee
      command = <<-SQL
      SELECT t.id, t.priority_number, t.description, t.creation_date, t.complete, t.pid, p.name
      FROM joins_tasks_employees AS te
      JOIN tasks AS t
      ON te.tid = t.id
      JOIN projects AS p
      ON t.pid = pid
      WHERE te.eid = '#{eid}' AND t.complete = true;
      SQL

      @db_adaptor.exec(command).values #returns an array
    end

####################################
    # @db.update_task(id, data)

        # def delete_task(task_id) #deletes a task
    #   command = <<-SQL
    #     DELETE
    #     FROM tasks
    #     WHERE id = ('#{task_id}')
    #     RETURNING *;
    #   SQL

    #   result = @db_adaptor.exec(command).values[0]

    #   true
    #   # puts "Deleted task with id:#{task.id}."

    # end

    # def get(id) #gets the project we want, make a method in project?
    #   command = <<-SQL
    #     SELECT *
    #     FROM projects
    #     WHERE id = ('#{id}')
    #   SQL

    #   result = @db_adaptor.exec(command).values.first

    #   TM::Project.new(result[0], result[1])
    # end

  end

  def self.orm
   @__orm_instance ||= ORM.new
  end

end

