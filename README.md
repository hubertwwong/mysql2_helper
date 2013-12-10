# mysql2_helper

A set of conveinence functions to make mysql2 a bit more rubyish.
Currently only has a CSV import function but will have more at some point.
Not really complete so use at your own risk.

# How to use.

### CSV IMPORT

#### 1. call the new constructor. possible params are below.
@params = {:url => "localhost", :user => "root", 
                  :password => "password", :db_name => "space_ship",
                  :table_name => "fleet", :filename => "/home/user/fleet.csv"}
@db = Mysql2Helper.new(@params)

#### 2. call import_csv. this will read the csv file and load the data into the table.
@db_params = {:filename => "/home/user/fleet.csv",
                :concurrent_flag => true,
                :replace_flag => true,
                :table_name => "space_ship",
                :fields_term_by => "\t",
                :fields_enclosed_by => "\"",
                :line_term_by => "\r\n",
                :skip_num_lines => 1,
                :col_names => ["@dummy", "name", "description"],
                :set_col_names => ["column2='dummy'"]}
result = @db.import_csv(@db_params)

### CSV IMPORT OPTIONS

These are the options that you can pass in to the param hash. 
They should correspond to the LOAD DATA function.
Options with the flag suffix should be boolean values.
All other options should take strings with the exception of skip_num_lines 
which takes an int.

filename
table_name
low_priority_flag
concurrent_flag
local_flag
replace_flag
ignore_flag
fields_term_by
fields_enclosed_by
fields_escaped_by
line_start_by
line_term_by
skip_num_lines    
col_names
set_col_names    