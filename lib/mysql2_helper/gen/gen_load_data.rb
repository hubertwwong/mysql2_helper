# a string generating class so you can load into db.
class GenLoadData
  
  # constructs the mysql string to insert the data
  def self.create(params = {})
    # make some of the params optional.
    params = {
              low_priority_flag: nil,
              concurrent_flag: nil,
              local_flag: nil,
              replace_flag: nil,
              ignore_flag: nil,
              skip_num_lines: nil, 
              fields_term_by: nil,
              fields_enclosed_by: nil,
              fields_escaped_by: nil,
              line_start_by: nil,
              line_term_by: nil
             }.merge(params)
    
    
    # load params into variables.
    # ########################################################################
    
    filename = params.fetch(:filename)
    table_name = params.fetch(:table_name)
    
    # boolean values
    low_priority_flag = params.fetch(:low_priority_flag)
    concurrent_flag = params.fetch(:concurrent_flag)
    local_flag = params.fetch(:local_flag)
    replace_flag = params.fetch(:replace_flag)
    ignore_flag = params.fetch(:ignore_flag)
    
    fields_term_by = params.fetch(:fields_term_by)
    fields_enclosed_by = params.fetch(:fields_enclosed_by)
    fields_escaped_by = params.fetch(:fields_escaped_by)
    
    line_start_by = params.fetch(:line_start_by)
    line_term_by = params.fetch(:line_term_by)
    
    skip_num_lines = params.fetch(:skip_num_lines)
    
    col_names = params.fetch(:col_names)
    
    # INTIAL CHECKS
    
    # check if path exist.
    # if it doesn't exit the path.
    pn = Pathname.new filename
    if pn.exist? == false
      puts "error: csv does not exist."
      return false
    end
    
    if col_names == nil
      puts "error: need to define column names"
      return false
    end
    
    if line_term_by == nil
      puts "error: define line terminator. usually \n or \r\n"
      return false
    end
    
    # construct the db string.
    
    # initial sql statemet
    db_str = "LOAD DATA"
    
    # low priority, concurrent, local
    if low_priority_flag == true
      db_str = db_str + " LOW_PRIORITY"
    elsif concurrent_flag == true
      db_str = db_str + " CONCURRENT"
    end
    
    # file name
    db_str = db_str + " INFILE '" + filename + "'"
    
    # replace / ignore
    if replace_flag == true
      db_str = db_str + " REPLACE"
    elsif ignore_flag == true
      db_str = db_str + " IGNORE"
    end
    
    # into table         
    db_str = db_str + " INTO TABLE " + table_name
    
    # checks if the optional args fields are used.
    # if its is, add " FIELDS"
    if fields_term_by != nil || fields_enclosed_by != nil || fields_escaped_by != nil
      db_str = db_str + " FIELDS"
    end
    
    if fields_term_by != nil
      db_str = db_str + " TERMINATED BY '" + 
               fields_term_by + "'"
    end
    
    if fields_enclosed_by != nil
      db_str = db_str + " ENCLOSED BY '" + 
               fields_enclosed_by + "'"
    end
    
    if fields_escaped_by != nil
      db_str = db_str + " ESCAPED BY '" + 
               fields_escaped_by + "'"
    end
    
    # check if lines start by or end by is used
    # if it is, add " LINES"
    if line_start_by != nil || line_term_by != nil
      db_str = db_str + " LINES"
    end
    
    if line_start_by != nil
      db_str = db_str + " STARTING BY '" + 
               line_start_by + "'"
    end
    
    if line_term_by != nil
      db_str = db_str + " TERMINATED BY '" + 
               line_term_by + "'"
    end
    
    # if you have titles, add a number to skip those lines
    # so they don't get put into the db.
    if skip_num_lines != nil && skip_num_lines > 0
      db_str = db_str + " IGNORE " + skip_num_lines.to_s + " LINES"
    end
    
    # define the column names that you want to write to the db.
    # the actual names should match the db names.
    # if you dont want a column to be written, use @dummy.
    #
    # example
    # "@dummy, name, description"
    if col_names != nil
      db_str = db_str + " (" + 
               col_names + ")"
    end
    
    # add the semi colon
    db_str = db_str + ";"
    
    # debug stuff
    puts "> db query to write"
    puts db_str
    puts ""
    
    return db_str
  end
    
end