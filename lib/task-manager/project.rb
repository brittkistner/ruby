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

  def retrieve_completed_tasks
    sorted = @tasks.map do |x|
      if x.status == "complete"  #change out any arrays
        x
      end
    end
    sorted.compact.sort do |x,y| #returns nil value run compact on sorted
      x.creation_date <=> y.creation_date
    end

    sorted
  end

  def project_mark_complete(task_id)
    @tasks.map do |x|
      if x.task_id == id && x.status == "incomplete"
        x.mark_complete
        x
      end
    end
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
    sorted
  end

  def self.project_list
    @@project_list
  end

end

