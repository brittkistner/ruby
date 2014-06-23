require 'date'
require 'time'

class TM::Task

  attr_accessor :complete
  attr_reader :priority_number, :project_id, :creation_date, :description, :id


  def self.get(id)
    result = TM.orm.get_task(id)
    TM::Task.new(result[0],result[1], result[2], result[3], result[4],result[5])
  end

  def initialize(id, p_number, description, creation_date, complete, project_id)
    @id = Integer(id)
    @complete = complete == "t" ? true : false
    @creation_date = DateTime.parse(creation_date)
    @priority_number = Integer(p_number)
    @description = description
    @project_id = Integer(project_id)
  end

  def mark_complete
    TM.orm.mark(@id, @project_id)

    if @complete == false
      @complete = true
    end
  end

end
