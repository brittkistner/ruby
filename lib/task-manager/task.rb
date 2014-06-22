require 'date'
require 'time'

class TM::Task

  attr_accessor :complete
  attr_reader :priority_number, :project_id, :creation_date, :description, :task_id


  def initialize(id, p_number, description, creation_date, complete, project_id)
    @task_id = Integer(id)
    @complete = complete == "t" ? true : false
    @creation_date = DateTime.parse(creation_date)
    @priority_number = Integer(p_number)
    @description = description
    @project_id = Integer(project_id)

    #bring everything in and then convert to either integer or true or false
    #params[whatever number is complete, like 5] if "t" then @complete = true : if "f" then @complete = false
  end

  def mark_complete
    if @complete == false
      @complete = true
    end
  end

end
