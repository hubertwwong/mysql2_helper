require_relative "../../lib/mysql2_helper"

describe Mysql2Helper do
  
  describe "import_csv" do
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
    
    describe "import_csv" do
      before(:each) do
        @params = {:url => "localhost", :user => "root", 
                  :password => "password", :db_name => "space_ship",
                  :table_name => "fleet", :filename => "/home/user/fleet.csv"}
        @db = Mysql2Helper.new(@params)
      end
      
      it "basic" do
        db_params = params = {
                :concurrent_flag => true,
                :replace_flag => true,
                :fields_term_by => "\t",
                :line_term_by => "\r\n",
                :skip_num_lines => 1,
                :col_names => "@dummy, name, description"}
        result = @db.import_csv(db_params)
        expect(result).not_to eq(false)
      end
    end
  end
  
  describe "hello" do
    it "should return hello" do
      ms = Mysql2Helper.new
      expect(ms.hello).to eq('hello')
    end
  end
  
end