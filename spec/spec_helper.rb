# Require our project, which in turns requires everything else
require './lib/task-manager.rb'

RSpec.configure do |config|
  config.before(:all) do
    TM.orm.instance_variable_set(:@db_adaptor, PG.connect(host: 'localhost', dbname: 'task-manager-db-test'))
  end

  config.before(:each) do
    TM.orm.reset_tables
  end

  config.after(:all) do
    TM.orm.drop_tables
  end
end


