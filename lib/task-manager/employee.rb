class TM::Employee

  attr_reader :name, :id

  def initialize(id, name)
    @id = Integer(id)
    @name = name
  end

  #create show_employee_projects(eid) methods

  def self.add_employee(name)
    result = TM.orm.create_employee(name)
    TM::Employee.new(result[0], result[1])
  end

  def self.list_employees
    result = TM.orm.list_all_employees

    employees =[]

    result.each do |employee|
      employees << TM::Employee.new(employee[0], employee[1])
    end

    employees
  end

  def assign_task_to_employee(tid,eid)
    TM.orm.assign_task_to_employee(tid,@id) #return true
  end

  def self.show_employee_projects(eid)
    #this should return an employee name and return an array of projects (and id) for all employee projects
  end

  def self.incomplete_tasks(eid)
    result = TM.orm.employee_incomplete_tasks(eid)

    employee_tasks_incomplete = []

    result.each do |task|
      employee_tasks_incomplete << TM::Task.new(task[0], task[1],task[2],task[3],task[4],task[5])
    end

    employee_tasks_incomplete #returns an array
    #this should return an employee name and return an array of incomplete tasks (id, description, priority_number)
  end

  def self.complete_tasks(eid)
    TM.orm.employee_completed_tasks(eid)
    employee_tasks_complete = []

    result.each do |task|
      employee_tasks_complete << TM::Task.new(task[0], task[1],task[2],task[3],task[4],task[5])
    end

    employee_tasks_complete #returns an array
     #this should return an employee name and return an array of incomplete tasks (id, description, priority_number)
  end
end
