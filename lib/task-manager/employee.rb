class TM::Employee

  attr_reader :name, :employee_id

  def initialize(id, name)
    @employee_id = id
    @name = name
  end
end
