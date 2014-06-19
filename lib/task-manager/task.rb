class TM::Task

  attr_accessor :complete
  attr_reader :priority_number, :project_id, :creation_date, :description, :task_id


  def initialize(id, p_number, description, creation_date, complete, project_id)
    @task_id = id
    @complete = complete
    @creation_date = creation_date
    # self.priority_number = p_number
    @priority_number = p_number
    @description = description
    @project_id = project_id
  end

  # def priority_number=(number)
  #   if number > 5
  #     @priority_number = 5
  #   elsif number < 0
  #     @priority_number = 0
  #   else
  #     @priority_number = number
  #   end
  # end

  def mark_complete
    if @complete == false
      @complete = true
    end
  end

  # def self.generate_id
  #   tmp = @@id_counter ||= 0
  #   @@id_counter +=1
  #   tmp
  # end
end
