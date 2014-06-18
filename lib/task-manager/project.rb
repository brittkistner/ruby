require 'pg'

class TM::Project

  # @@class_id = 0
  # @@project_list = {} #to database

  @@db = PG.connect(host: 'localhost', dbname: 'task-manager-db')

  attr_reader :name, :db
  attr_accessor :id, :tasks

  def initialize(id, name)
    @id = id
    @name = name
  end

  def self.create(name)
    #instead of using an array, I want add_project to add a new project to the projects table of my db
    @@db.exec_params("INSERT INTO projects (name) VALUES ($1) returning id", [name]) do |result|
      return new(result.getvalue(0,0),name)
    end
  end

  def create_task(name, priority_number, description = nil)
    creation_date = Time.now
    @@db.exec_params("INSERT INTO tasks (name, priority_number, description, creation_date, project_id) VALUES ($1, $2, $3, $4, $5) returning id", [name, priority_number, description, creation_date, @id]) do |result|
      return TM::Task.new(result.getvalue(0,0),name, priority_number, description, creation_date, @id)
    end
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
    sorted
  end

  def self.get(id) #gets the project we want
    @@db.exec_params("SELECT name FROM projects WHERE id = $1", [id]) do |result|
      new(id,result.getvalue(0,0))
    end
  end
end

