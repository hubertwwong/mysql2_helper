require 'mysql2'

class Mysql2Helper
  
  attr_accessor :client, :url, :user, :password, :db_name, :table_name, :filename
  
  def initialize(params = {})
    # make the params optional.
    params = {
              client: nil,
              url: nil, 
              user: nil, 
              password: nil,
              db_name: nil,
              table_name: nil,
              filename: nil
             }.merge(params)
    
    # load params into instance variables.
    @url = params.fetch(:url)
    @user = params.fetch(:user)
    @password = params.fetch(:password)
    @db_name = params.fetch(:db_name)
    @table_name = params.fetch(:table_name)
    @filename = params.fetch(:filename)
    
    # connect to db.
    self.connect
  end
  
  def import_csv
    
  end
  
  # connections
  ############################################################################
  
  # connects to db.
  def connect
    # connect to db.      
    @client = Mysql2::Client.new(:host => @url, 
                             :database => @db_name,
                             :username => @user, 
                             :password => @password)
  end
  
  # close the db connection.
  # might need to call this if the one in the mysql2 client
  # is not fast enough.
  def close
    @client
  end
  
  # TEMP
  ############################################################################
  
  # used to test if the class is setup correcty.
  def hello
    "hello"
  end
    
end