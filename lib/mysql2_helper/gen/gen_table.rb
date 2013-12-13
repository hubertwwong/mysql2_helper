require_relative "gen_string"

# for sql table creation, deletion, update, drops.
#
class GenTable
  
  # clones a table.
  def self.create_clone(params = {})
    if params == nil
      puts "error: please enter the tbl_name and old_tbl_name parmas"
      return nil
    end
    
    params = {
              tbl_name: nil,
              old_tbl_name: nil,
              temporary_flag: nil,
              if_not_exist_flag: nil
             }.merge(params)
    
    tbl_name = params.fetch(:tbl_name)
    old_tbl_name = params.fetch(:old_tbl_name)
    temporary_flag = params.fetch(:temporary_flag)
    if_not_exist_flag = params.fetch(:if_not_exist_flag)
    
    # intial checks.
    ##########################
    
    if tbl_name == nil
      puts "error: tbl_name param is nil"
      return nil  
    end
    
    if old_tbl_name == nil
      puts "error: old_tbl_name param is nil"
      return nil  
    end
    
    # construct the db string.
    ##########################
    
    # initial sql statemet
    db_str = "CREATE"
    
    db_str = GenString.append_if_true(db_str, " TEMPORARY", temporary_flag)
    
    # KEYWORD TABLE
    db_str = db_str + " TABLE"
    
    db_str = GenString.append_if_true(db_str, " IF NOT EXISTS", if_not_exist_flag)
    
    # table names.
    db_str = db_str + " " + tbl_name +
             " LIKE " + old_tbl_name + ";"  
    
    # debugging
    GenString.pp db_str
    
    
    return db_str
  end
  
  # DROPS A TABLE
  def self.drop(params = {})
    if params == nil
      puts "error: please enter the tbl_name"
      return nil
    end
    
    params = {
              tbl_name: nil,
              temporary_flag: nil,
              if_exist_flag: nil,
             }.merge(params)
             
    
    tbl_name = params.fetch(:tbl_name)
    temporary_flag = params.fetch(:temporary_flag)
    if_exist_flag = params.fetch(:if_exist_flag)
    
    # intial checks.
    ##########################
    
    if tbl_name == nil
      puts "error: tbl_name param is nil"
      return nil  
    end
    
    # construct the db string.
    ##########################
    
    # initial sql statemet
    db_str = "DROP"
    
    # temp tables only flag.
    db_str = GenString.append_if_true(db_str, " TEMPORARY", temporary_flag)
    
    # table keyword
    db_str = db_str + " TABLE"
    
    # supress errors if the table does not exist
    db_str = GenString.append_if_true(db_str, " IF EXISTS", if_exist_flag)
    
    # table name...
    # if its just a string, just append it.
    # otherwise assume its a array.
    if tbl_name.instance_of?(String)
      db_str = db_str + " " + tbl_name
    elsif tbl_name.instance_of?(Array)
      tbl_list = GenString.array_to_comma_str(tbl_name)
      db_str = db_str + " " + tbl_list
    else
      puts "error: tbl_name needs to be a string or Array"
      return nil
    end
    
    # semicolon to end statement.
    db_str = db_str + ";"
    
    # debugging
    GenString.pp db_str
    
    return db_str
  end
  
end