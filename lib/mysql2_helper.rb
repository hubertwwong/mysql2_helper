require 'mysql2'

class Mysql2Helper
  
  attr_accessor :client, :url, :user, :password, :db_name
  
  def initialize(params = {})
    @url = params.fetch(:url)
    @user = params.fetch(:user)
    @password = params.fetch(:password)
    @db_name= params.fetch(:db_name)
    
    @client = self.connect
  end
  
  def import_csv
    
  end
  
  
  def connect
    # connect to db.      
    return Mysql2::Client.new(:host => @url, 
                             :database => @db_name,
                             :username => @user, 
                             :password => @password)
  end
  
  # TEMP
  ############################################################################
  
  # used to test if the class is setup correcty.
  def hello
    "hello"
  end
    
end