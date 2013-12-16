require_relative "../../lib/mysql2_helper"

describe Mysql2Helper do
  
  describe "load_data" do
    describe "instance variables" do
      before(:each) do
        @params = {:url => "localhost", :user => "root", 
                   :password => "password", :db_name => "space_ship",
                   :table_name => "foo", :filename => "foo.txt"}
        @db = Mysql2Helper.new(@params)
      end
      
      it "url" do
        expect(@db.url).to eq("localhost")
      end
      
      it "user" do
        expect(@db.user).to eq("root")
      end
      
      it "password" do
        expect(@db.password).to eq("password")
      end
      
      it "db_name" do
        expect(@db.db_name).to eq("space_ship")
      end
      
      it "table_name" do
        expect(@db.table_name).to eq("foo")
      end
      
      it "filename" do
        expect(@db.filename).to eq("foo.txt")
      end
    end
    
    describe "create" do
      before(:each) do
        @params = {:url => "localhost", :user => "root", 
                   :password => "password", :db_name => "space_ship",
                   :table_name => "fleet", :filename => "/home/user/fleet.csv"}
        @db = Mysql2Helper.new(@params)
      end
      
      xit "basic" do
        db_params = {:concurrent_flag => true,
                     :replace_flag => true,
                     :fields_term_by => "\t",
                     :line_term_by => "\r\n",
                     :skip_num_lines => 1,
                     :col_names => ["@dummy", "name", "description"]}
        result = @db.load_data(db_params)
        expect(result).to eq(true)
      end
      
      xit "basic using set" do
        db_params = {:concurrent_flag => true,
                     :replace_flag => true,
                     :fields_term_by => "\t",
                     :line_term_by => "\r\n",
                     :skip_num_lines => 1,
                     :col_names => ["@dummy", "name", "description"],
                     :set_col_names => ["name='dummy dummy'"]}
        result = @db.load_data(db_params)
        expect(result).to eq(true)
      end
    end
  end
  
  describe "table" do
    describe "create_clone" do
      before(:each) do
        @params = {:url => "localhost", :user => "root", 
                  :password => "password", :db_name => "space_ship"}
        @db = Mysql2Helper.new(@params)
      end
      
      xit "basic" do
        db_params = {:tbl_name => "foo",
                     :old_tbl_name =>"fleet"}
        result = @db.create_clone(db_params)
        expect(result).to eq(true)
      end
    end
    
    describe "drop" do
      before(:each) do
        @params = {:url => "localhost", :user => "root", 
                  :password => "password", :db_name => "space_ship"}
        @db = Mysql2Helper.new(@params)
      end
      
      xit "basic" do
        db_params = {:tbl_name => "foo"}
        result = @db.drop(db_params)
        expect(result).to eq(true)
      end
    end
  end
  
  describe "update" do
    describe "update_multi" do
      before(:each) do
        @params = {:url => "localhost", :user => "root", 
                  :password => "password", :db_name => "space_ship"}
        @db = Mysql2Helper.new(@params)
      end
      
      # testing creating a teep table and cloning it.
      it "basic" do
        #db_params = {:tbl_name => "foo",
        #             :old_tbl_name =>"fleet"}
        #result = @db.create_clone(db_params)
        
        db_params = {:tbl_ref => "fleet f LEFT JOIN foo g ON (f.name=g.name AND f.name2=g.name2)",
                     :set_ref => "g.description=f.description"}
        result = @db.update_multi(db_params)
        
        expect(result).to eq(true)
      end
    end
  end
  
  describe "hello" do
    xit "should return hello" do
      ms = Mysql2Helper.new
      expect(ms.hello).to eq('hello')
    end
  end
  
end