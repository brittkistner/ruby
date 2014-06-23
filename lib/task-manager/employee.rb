class TM::Employee

  attr_reader :name, :id

  def initialize(id, name)
    @id = Integer(id)
    @name = name
  end

  def self.get(id)
    result = TM.orm.get_employee(id)
    TM::Employee.new(result[0],result[1])
  end

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

  def assign_task_to_employee(tid)
    TM.orm.assign_task_to_employee(tid,@id) #return true
  end

  def show_employee_projects
    result = TM.orm.show_employee_projects(@id)

    employee_projects = []

    result.each do |project|
      employee_projects << TM::Project.new(project[0], project[1])
    end

    employee_projects

    #this should return an array of projects for an employee
  end

  def incomplete_tasks
    result = TM.orm.employee_incomplete_tasks(@id)

    employee_tasks_incomplete = []

    result.each do |task|
      employee_tasks_incomplete << TM::Task.new(task[0], task[1],task[2],task[3],task[4],task[5])
    end

    employee_tasks_incomplete #returns an array
  end

  def complete_tasks
    result = TM.orm.employee_completed_tasks(@id)
    employee_tasks_complete = []

    result.each do |task|
      employee_tasks_complete << TM::Task.new(task[0], task[1],task[2],task[3],task[4],task[5])
    end

    employee_tasks_complete
  end
end
