require_relative "gen_string"

# Update statement.
#
class GenUpdate
  
  # update command using the multiple statement sytax
  # when using the multiple table syntax, you can't use the order or limit
  # params.
  def self.update_multi(params = {})
    if params == nil
      puts "error: please enter the tbl_name and old_tbl_name parmas"
      return nil
    end
    
    params = {
              tbl_ref: nil,
              set_ref: nil,
              where_ref: nil,
              low_priority_flag: nil,
              ignore_flag: nil
             }.merge(params)
    
    tbl_ref = params.fetch(:tbl_ref)
    set_ref = params.fetch(:set_ref)
    where_ref = params.fetch(:where_ref)
    low_priority_flag = params.fetch(:low_priority_flag)
    ignore_flag = params.fetch(:ignore_flag)
    
    # intial checks.
    ##########################
    
    if tbl_ref == nil
      puts "error: tbl_ref param is nil"
      return nil  
    end
    
    if set_ref == nil
      puts "error: set_ref param is nil"
      return nil  
    end
    
    # construct the db string.
    ##########################
    
    # initial sql statemet
    db_str = "UPDATE"
    
    db_str = GenString.append_if_true(db_str, " LOW_PRIORITY", low_priority_flag)
    
    db_str = GenString.append_if_true(db_str, " IGNORE", ignore_flag)
    
    # TABLE ref
    db_str = db_str + " " + tbl_ref
    
    # SET ref
    db_str = db_str + " SET " + set_ref 
    
    # where clause
    db_str = GenString.append_not_nil(db_str,  where_ref, true)
    
    # termination
    db_str = db_str + ";"
    
    # debugging
    GenString.pp db_str
    
    return db_str
  end
    
end


#UPDATE  table1 a
#        INNER JOIN table2 b
#            ON a.ID = b.ID
#SET     a.value = b.value 