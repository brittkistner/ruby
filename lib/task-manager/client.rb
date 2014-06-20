module Client

  def self.print_menu
    puts "Welcome to Project Manager.  What would you like to do?"
    puts "Available Commands:"
    puts "--Type 'project list' - to list all projects"
    puts "--Type 'project create NAME' - to create a new project"
    puts "--Type 'project show PID' - Show remaining tasks for project PID"
    puts "--Type 'project history PID' - Show completed tasks for project PID"
    puts "--Type 'project employees PID' - Show employees participating in this project"
    puts "--Type 'project recruit PID EID' - Adds employee EID to participate in project PID"
    puts "--Type 'task create PID NAME_TASK PRIORITY_NUMBER DESCRIPTION' to add a task for project id = PID"
    puts "--Type 'task list PID' to show all tasks for project id = PID"
    puts "--Type 'task complete PID' to show all complete tasks for project id = PID"
    puts "--Type 'task incomplete PID' to show all incomplete tasks for project id = PID"
    puts "--Type 'task mark TID' to mark a task with id =TID as complete"
    puts "--Type 'task assign TID EID' - Assign task to employee"
    puts "--Type 'emp list EID' - List all employees"
    puts "--Type 'emp create NAME' - Create a new employee"
    puts "--Type 'emp show EID' - Show employee EID and all participating projects"
    puts "--Type 'emp details EID' - Show all remaining tasks assigned to employee EID,
                      along with the project name next to each task"
    puts "--Type 'emp history EID' - Show completed tasks for employee with id=EID"
    puts "--Type 'quit' to exit"
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
          TM.list_projects
        when 'create'
          name = user_input[1]
          TM.new_project(name)
        when 'show' # TODO puts "--Type 'project show PID' - Show remaining tasks for project PID"
          #lists tasks
          pid = Integer(user_input[2])
          TM.task_list_for_each_project(pid)
        when 'history' # TODO puts "--Type 'project history PID' - Show completed tasks for project PID"
          pid = Integer(user_input[2])
          TM.complete
        when 'employees' # TODO puts "--Type 'project employees PID' - Show employees participating in this project"
          pid = Integer(user_input[2])
        when 'recruit'# TODO puts "--Type 'project recruit PID EID' - Adds employee EID to participate in project PID
          pid = Integer(user_input[2])
          eid = Integer(user_input[3])
        else
          puts 'Invalid Command'
          next
        end
      elsif user_input[0] == "task"
        case user_input[1]
        when 'create' #puts "--Type 'task create PID NAME_TASK PRIORITY_NUMBER DESCRIPTION' to add a task for project id = PID"
          pid = Integer(user_input[2])
          name = user_input[3]
          priority_number = Integer(user_input[4])
          description = user_input.length < 5 ? nil : user_input[5]

          project = TM::Project.get(pid)
          new_task = project.create_task(name,priority_number,description)
        when 'list' #TODO puts "--Type 'task list PID' to show all tasks for project id = PID"
          pid = Integer(user_input[2])
        when 'mark' #TODO puts "--Type 'task mark TID' to mark a task with id =TID as complete"
          tid = Integer(user_input[2])
          TM.mark
        when 'assign' #TODO puts "--Type 'task assign TID EID' - Assign task to employee
          tid = Integer(user_input[2])
          eid = Integer(user_input[3])
        else
          puts 'Invalid Command'
          next
        end
      elsif user_input[0] == "emp"
        case user_input[1]
        when 'list' # puts "--Type 'emp list EID' - List all employees
          eid = Integer(user_input[2])
        when 'create' # puts "--Type 'emp create NAME' - Create a new employee
          name = Integer(user_input[2])
        when 'show' # puts "--Type 'emp show EID' - Show employee EID and all participating projects
          eid = Integer(user_input[2])
        when 'details'
           # puts "--Type 'emp details EID' - Show all remaining tasks assigned to employee EID,
           #         along with the project name next to each task
          eid = Integer(user_input[2])
        when 'history' # puts "--Type 'emp history EID' - Show completed tasks for employee with id=EID
          eid = Integer(user_input[2])
        else
          puts 'Invalid Command'
        end
      else
        puts 'Invalid Command'
      end
    end
  end

  def self.list_projects
    TM::Project.list
  end

  def self.new_project(name)
    new_project = TM::Project.create(name)
    puts "Created #{new_project.name} with PID: #{new_project.id}"
  end

  # def self.add_task(name,priority_number,description,pid)

  # end

  def self.task_list_for_each_project(pid)
    task_list = TM::Project.task_list(pid)
    puts "Task List: #{task_list}"
  end

  def self.complete
    project = TM::Project.project_list[pid]
    project.retrieve_completed_tasks
  end

  def self.incomplete
    project = TM::Project.project_list[pid]
    project.retrieve_incomplete_tasks
  end

  def self.mark
    task = TM::Project.mark[tid]
    task.mark_complete
    puts "Task #{task.task_id} completed"
  end

end

require_relative 'task-manager/task.rb'
require_relative 'task-manager/project.rb'
