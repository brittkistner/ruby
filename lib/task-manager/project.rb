require 'pg'

class TM::Project

  # @@class_id = 0
  # @@project_list = {} #to database

  @@db = PG.connect(host: 'localhost', dbname: 'task-manager')

  attr_reader :name, :db
  attr_accessor :id, :tasks

  def initialize(name)
    @name = name
    # @id = self.generate_id //to database
    # @id = @@class_id +=1
    @tasks = [] #create in the database
    @@project_list[@id] = self
  end

  def self.add_project(project)
    #instead of using an array, I want add_project to add a new project to the projects table of my db
    result = @@db.exec("INSERT INTO projects (name) VALUES (#{project.name}") RETURNING
  end

  def create_task(name, priority_number, description = nil)
    task = TM::Task.new(name, priority_number, description, @id)
    @tasks << task #switch to database
    task
  end

  def project_mark_complete(task_id)
    @tasks.map do |x|
      if x.task_id == id && x.status == "incomplete"
        x.mark_complete
        x
      end
    end
  end

  def retrieve_completed_tasks
    sorted = @tasks.map do |x|
      if x.status == "complete"
        x
      end
    end
    sorted.compact.sort do |x,y| #returns nil value run compact on sorted
      x.creation_date <=> y.creation_date
    end

    # return tasks??
  end

  def retrieve_incomplete_tasks
    #sorted by priority
    #if priorities are equal
    #sort by creation date (oldest first)
    sorted = @tasks.map do |x|
      if x.status == "incomplete"
        x
      end
    end
    sorted.compact.sort do |x, y|
      if x.priority_number != y.priority_number
        x.priority_number <=> y.priority_number
      else
        x.creation_date <=> y.creation_date
      end
    end
    #return task names??
  end

  # def self.project_list(project)
  #   @@project_list
  # end
end

