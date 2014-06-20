require 'pg'
require 'pry-byebug'

class TM::Project

  attr_reader :name
  attr_accessor :id #:tasks #add time

  def initialize(name,id)
    @id = id
    @name = name
    # @task =[]
  end

  def create_task(name, priority_number, description = nil)
    task = TM::Task.new(name, priority_number, description, @id)
    @tasks << task
    task
  end

  def self.projects
    TM.orm.list_projects
  end

  def retrieve_completed_tasks(pid)
    tasks_complete = TM.orm.complete(pid)
    tasks_complete
  end

  def project_mark_complete(task_id)

    task = TM.orm.mark(task_id, @id)
    #what should it return? it now returns a task instance
    puts task.complete #make this into a string
  end


  def retrieve_incomplete_tasks(pid) #@id?
    #sorted by priority
    #if priorities are equal
    #sort by creation date (oldest first)

    tasks_incomplete = TM.orm.incomplete(pid)
    tasks_incomplete
  end

end

