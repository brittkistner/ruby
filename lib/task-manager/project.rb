require 'pg'
require 'pry-byebug'

class TM::Project

  attr_reader :name
  attr_accessor :id



  def initialize(name,id)
    @id = Integer(id)
    @name = name
  end

  def self.add_project(name)
    result = TM.orm.add_project(name)

    project = TM::Project.new(result[0], result[1])

    project
    #return a project instance
  end

  def self.list_projects
    result = TM.orm.list_projects

    projects = []

    result.each do |project|
      projects << TM::Project.new(project[0], project[1])
    end

    projects
  end

  def create_task(priority_number,description,id)
    result = TM.orm.create_task(priority_number,description,@id)
    task = TM::Task.new(result[0], result[1], result[2], result[3], result[4],result[5])
    task #returns task object
  end

  def task_list(pid)
    result = TM.orm.task_list(pid)

    tasks =[]

    result.each do |task|
      tasks << TM::Task.new(task[0], task[1],task[2],task[3],task[4],task[5])
    end

    tasks #returns an array
  end

  def project_mark_complete(task_id,pid)
    TM.orm.mark(task_id, pid) #returns true
  end

  def retrieve_completed_tasks(pid)
    result = TM.orm.complete(pid)

    tasks_complete = []

    result.each do |task|
      tasks_complete << TM::Task.new(task[0], task[1],task[2],task[3],task[4],task[5])
    end

    tasks_complete #returns an array of completed tasks
  end

  def retrieve_incomplete_tasks(pid)
    #sorted by priority
    #if priorities are equal
    #sort by creation date (oldest first)

    result = TM.orm.incomplete(@id) #returns an array

    tasks_incomplete = []

    result.each do |task|
      tasks_incomplete << TM::Task.new(task[0], task[1],task[2],task[3],task[4],task[5])
    end

    tasks_incomplete #returns an array of incomplete task objects
  end

  def self.show_employees_in_project(pid)
    #an erray of employee names and employee id in project
    result = TM.orm.show_employees_in_project(pid)

    employees =[]

    result.each do |employee|
      employees << TM::Employee.new(employee[0], employee[1])
    end

    employees
  end

  def self.add_employee_to_project(pid,eid)
    TM.orm.add_employee_to_project(pid,eid) #returns true
  end

end

