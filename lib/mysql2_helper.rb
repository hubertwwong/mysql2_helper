require "mysql2"

require_relative "mysql2_helper/gen/gen_load_data"
require_relative "mysql2_helper/gen/gen_table"
require_relative "mysql2_helper/gen/gen_update"
require_relative "mysql2_helper/gen/gen_string"

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
  
  # LOAD DATA
  ############################################################################
  
  def load_data(params = {})
    final_params = self.inject_db_params_with_filename(params)
    gld = GenLoadData.create(final_params)
    return self.run_query(gld)
  end
  
  # TABLE
  ############################################################################
  
  def create_clone(params = {})
    gld = GenTable.create_clone(params)
    return self.run_query(gld)
  end
  
  def drop(params = {})
    gld = GenTable.drop(params)
    return self.run_query(gld)
  end
  
  # update
  ############################################################################
  
  def update_multi(params = {})
    gld = GenUpdate.update_multi(params)
    return self.run_query(gld)
  end
  
  # helper methods
  ############################################################################
  
  # just runs a query if the string isn't nil
  def run_query(sql_string)
    if sql_string != nil
      @client.query(sql_string)
      puts "query successful"
      return true
    else
      puts "query failed"
      return false
    end
  end
  
  # inject_db_params_with_filename
  #
  # injects the db_name, table_name, and file_name
  # into the param hash.
  # used for the string generation functions.
  def inject_db_params_with_filename(params = {})
    injected_params = params
    injected_params[:db_name] = @db_Name
    injected_params[:table_name] = @table_name
    injected_params[:filename] = @filename
    
    return injected_params
  end
  
  # inject_db_params
  #
  # injects the db_name, table_name
  # into the param hash.
  # used for the string generation functions.
  def inject_db_params(params = {})
    injected_params = params
    injected_params[:db_name] = @db_Name
    injected_params[:table_name] = @table_name
    
    return injected_params
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
    @client.close
  end
  
  # TEMP
  ############################################################################
  
  # used to test if the class is setup correcty.
  def hello
    "hello"
  end
    
end