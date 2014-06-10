require 'time' # you're gonna need it

class Bar
  attr_reader :name, :menu_items, :happy_hour

  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
    @happy_hour = Time.now
  end

  def add_menu_item(item, price)
    @menu_items << MenuItem.new(item, price)
  end

  def happy_discount #attr_reader
    if happy_hour?
      @happy_discount
    else
      0
    end
  end

  def happy_discount=(happy_discount = 0.5) #attr_writer
    if happy_discount > 1
      @happy_discount = 1
    elsif happy_discount < 0
      @happy_discount = 0
    else
      @happy_discount = happy_discount
    end
  end

  def happy_hour?
    #? return true or false
    begin_variable = Time.parse("15:00")
    end_variable = Time.parse("16:00")

    if Time.now > begin_variable && Time.now < end_variable
      true
    else
      false
    end
  end

  def get_price(drink_name)
    #stub time?
    #find the drink name within the menu
    #check whether hh = true, if true return discounted price
    # if not hh, return the regular price
    @menu_items.each do |x|
      if x.name == drink_name
        if happy_hour? == true
          return (x.price) * (1 - @happy_discount)
        else
          return price
        end
      end
    end
  end
end

class MenuItem
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end
