class TM::Task

  attr_accessor :complete
  attr_reader :priority_number, :project_id, :name, :creation_date, :description, :task_id


  def initialize(id, name, p_number,description=nil, creation_date, project_id)
    @task_id = self.class.generate_id
    @name = name
    @complete = false
    @creation_date = creation_date
    self.priority_number = p_number #remove @ and change to p_number?
    @description = description
    @project_id = project_id
  end

  def priority_number=(number)
    if number > 5
      @priority_number = 5
    elsif number < 0
      @priority_number = 0
    else
      @priority_number = number
    end
  end

  def mark_complete
    if @complete == false
      @complete = true
    end
  end

  def self.generate_id
    tmp = @@id_counter ||= 0
    @@id_counter +=1
    tmp
  end

end
