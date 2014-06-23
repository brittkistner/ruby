class TM::Client

  def self.print_menu
    puts "Welcome to Project Manager.  What would you like to do?"
    puts "Available Commands:"
    puts "--Type 'project list' - to list all projects"
    puts "--Type 'project create NAME' - to create a new project"
    puts "--Type 'project show PID' - Show remaining tasks for project PID"
    puts "--Type 'project history PID' - Show completed tasks for project PID"
    puts "--Type 'project employees PID' - Show employees participating in this project"
    puts "--Type 'project recruit PID EID' - Adds employee EID to participate in project PID"
    puts "--Type 'task create PID PRIORITY_NUMBER DESCRIPTION' to add a task for project id = PID"
    puts "--Type 'task list PID' to show all tasks for project id = PID"
    puts "--Type 'task mark TID PID' to mark a task with id = TID as complete"
    puts "--Type 'task assign TID EID' - Assign task to employee"
    puts "--Type 'emp list' - List all employees"
    puts "--Type 'emp create NAME' - Create a new employee"
    puts "--Type 'emp show EID' - Show employee EID and all participating projects"
    puts "--Type 'emp details EID' - Show all remaining tasks assigned to employee EID,
                      along with the project name next to each task"
    puts "--Type 'emp history EID' - Show completed tasks for employee with id=EID"
    puts "--Type 'quit' to exit"

    # puts "Deleted task with id:#{task.id}."
  end

  def self.run
    print_menu
    while true

      puts "--Type your command or type 'help' for the menu"
      user_input = gets.downcase.split

      if user_input.length == 0
        puts "Invalid Command"
        next
      elsif user_input[0] == "help"
        print_menu
      elsif user_input[0] == "quit"
        break
      elsif user_input[0] == "project"
        case user_input[1]
        when 'list'
          self.list_projects
        when 'create'
          name = user_input[2]
          self.new_project(name)
        when 'show'
          pid = Integer(user_input[2])
          self.task_list_for_each_project(pid)
        when 'history'
          pid = Integer(user_input[2])
          self.completed_tasks_for_single_project(pid)
        when 'employees'
          pid = Integer(user_input[2])
          self.show_employees_in_project(pid)
        when 'recruit'
          pid = Integer(user_input[2])
          eid = Integer(user_input[3])
          self.add_employee_to_project(pid,eid)
        else
          puts 'Invalid Command'
          next
        end
      elsif user_input[0] == "task"
        case user_input[1]
        when 'create'
          pid = Integer(user_input[2])
          priority_number = Integer(user_input[3])
          description = user_input[4]
          self.create_task(priority_number, description, pid)
        when 'list'
          pid = Integer(user_input[2])
          self.task_list(pid)
        when 'mark'
          tid = Integer(user_input[2])
          pid = Integer(user_input[3])
          self.mark(tid,pid)
        when 'assign'
          tid = Integer(user_input[2])
          eid = Integer(user_input[3])
          self.assign_task_to_employee(tid,eid)
        else
          puts 'Invalid Command'
          next
        end
      elsif user_input[0] == "emp"
        case user_input[1]
        when 'list'
          self.list_employees
        when 'create'
          name = user_input[2]
          self.new_employee(name)
        when 'show'
          eid = Integer(user_input[2])
          self.employee_and_projects(eid)
        when 'details'
          eid = Integer(user_input[2])
          self.employee_incomplete_tasks(eid)
        when 'history'
          eid = Integer(user_input[2])
          self.employee_complete_tasks(eid)
        else
          puts 'Invalid Command'
        end
      else
        puts 'Invalid Command'
      end
    end
  end

#Project Methods
  def self.list_projects
    TM::Project.list_projects.each do |proj|
      puts "\n"
      puts "Project Name: #{proj.name}"
      puts "Project ID: #{proj.id}"
      puts "\n"
    end
  end

  def self.new_project(name)
    new_project = TM::Project.add_project(name)
    puts "Created #{new_project.name} with project id: #{new_project.id}"
  end

  def self.task_list_for_each_project(pid)
      puts "Incompleted Tasks:"
      project = TM::Project.get(pid)
      project.retrieve_incomplete_tasks.each do |task|
      puts "\n"
      puts "task ID: #{task.id}"
      puts "task ID: #{task.description}"
      puts "\n"
    end
  end

  def self.completed_tasks_for_single_project(pid)
    project = TM::Project.get(pid)
    puts "Completed Tasks:"
    project.retrieve_completed_tasks.each do |task|
      puts "\n"
      puts "task ID: #{task.id}"
      puts "task ID: #{task.description}"
      puts "\n"
    end
  end

  def self.show_employees_in_project(pid)
    project = TM::Project.get(pid)
    employee_list = project.show_employees_in_project
    employee_list.each do |employee|
      puts "\n"
      puts "Employee Name: #{employee.name}"
      puts "Employee ID: #{employee.id}"
      puts "\n"
    end
  end

  def self.add_employee_to_project(pid,eid)
    project = TM::Project.get(pid)
    project.add_employee_to_project(eid)
    employee = TM::Employee.get(eid)
    puts "\n"
    puts "Added #{employee.name} with id: #{eid} to #{project.name} with pid: #{pid}" #names of project and employee?
    puts "\n"
  end

#Task Methods

  def self.create_task(priority_number, description, pid)
    project = TM::Project.get(pid)
    task = project.create_task(priority_number,description)
    puts "\n"
    puts "Task #{task.id} created"
    puts "Task Priority Number: #{task.priority_number}"
    puts "Task Description: #{task.description}"
    puts "Task Description: #{task.creation_date}"
    puts "Task Description: #{task.project_id}"
    puts "\n"
  end

  def self.task_list(pid)
    project = TM::Project.get(pid)
    task_list = project.task_list
    task_list.each do |task|
      puts "\n"
      puts "Task ID: #{task.id}"
      puts "Task Priority Number: #{task.priority_number}"
      puts "Task Description: #{task.description}"
      puts "\n"
    end
  end

  def self.mark(tid,pid)
    project = TM::Project.get(pid)
    task = project.get_task(tid)
    task.mark_complete
    puts "\n"
    puts "Task ID: #{tid} marked complete"
    puts "\n"
  end

  def self.assign_task_to_employee(tid,eid)
    employee = TM::Employee.get(eid)
    employee.assign_task_to_employee(tid)
    puts "\n"
    puts "Task ID: #{tid} assigned to #{employee.name} with id: #{eid}." #use employee name?
    puts "\n"
  end

#Employee Methods

  def self.new_employee(name)
    employee = TM::Employee.add_employee(name)
    puts "Created #{employee.name} with EID: #{employee.id}"
  end

  def self.list_employees
    employee_list = TM::Employee.list_employees
    employee_list.each do |employee|
    puts "\n"
    puts "Employee Name: #{employee.name}"
    puts "Employee ID: #{employee.id}"
    puts "\n"
    end
  end

  def self.employee_and_projects(eid)
    employee = TM::Employee.get(eid)
    employee_projects = employee.show_employee_projects
    puts "\n"
    puts "Projects for #{employee.name}"
    employee_projects.each do |proj|
      puts "\n"
      puts "Project Name: #{proj.name}"
      puts "Project ID: #{proj.id}"
      puts "\n"
    end
  end

  def self.employee_incomplete_tasks(eid)
    employee = TM::Employee.get(eid)
    employee_incomplete_tasks = employee.incomplete_tasks
    employee_incomplete_tasks.each do |task|
      puts "Incomplete Tasks"
      puts "\n"
      puts "Task ID: #{task.id}"
      puts "Task Priority Number: #{task.priority_number}"
      puts "Task Description: #{task.description}"
      puts "\n"
    end
  end

  def self.employee_complete_tasks(eid)
    employee = TM::Employee.get(eid)
    employee_complete_tasks = employee.complete_tasks
    employee_complete_tasks.each do |task|
      puts "Complete Tasks"
      puts "\n"
      puts "Task ID: #{task.id}"
      puts "Task Priority Number: #{task.priority_number}"
      puts "Task Description: #{task.description}"
      puts "\n"
    end
  end

end

