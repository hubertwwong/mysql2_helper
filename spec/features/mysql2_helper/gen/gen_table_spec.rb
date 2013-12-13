require_relative "../../../../lib/mysql2_helper/gen/gen_table"

describe GenTable do
  
  describe "create_clone" do
    it "basic" do
      params = {:tbl_name => "foo",
                :old_tbl_name => "bar"}
      final_str = "CREATE TABLE foo LIKE bar;"
      
      result = GenTable.create_clone params
      expect(result).to eq(final_str)
    end
    
    it "if not exist" do
      params = {:tbl_name => "foo",
                :old_tbl_name => "bar",
                :if_not_exist_flag => true}
      final_str = "CREATE TABLE IF NOT EXISTS foo LIKE bar;"
      
      result = GenTable.create_clone params
      expect(result).to eq(final_str)
    end
    
    it "temporary" do
      params = {:tbl_name => "foo",
                :old_tbl_name => "bar",
                :temporary_flag => true}
      final_str = "CREATE TEMPORARY TABLE foo LIKE bar;"
      
      result = GenTable.create_clone params
      expect(result).to eq(final_str)
    end
    
    it "nil params" do
      result = GenTable.create_clone nil
      expect(result).to eq(nil)
    end
  end
  
  describe "DROP" do
    it "basic" do
      params = {:tbl_name => "foo"}
      final_str = "DROP TABLE foo;"
      
      result = GenTable.drop params
      expect(result).to eq(final_str)
    end
    
    it "if exist" do
      params = {:tbl_name => "foo",
                :if_exist_flag => true}
      final_str = "DROP TABLE IF EXISTS foo;"
      
      result = GenTable.drop params
      expect(result).to eq(final_str)
    end
    
    it "temporary" do
      params = {:tbl_name => "foo",
                :temporary_flag => true}
      final_str = "DROP TEMPORARY TABLE foo;"
      
      result = GenTable.drop params
      expect(result).to eq(final_str)
    end
    
    it "2 tables" do
      params = {:tbl_name => ["foo", "bar"]}
      final_str = "DROP TABLE foo, bar;"
      
      result = GenTable.drop params
      expect(result).to eq(final_str)
    end
  end
  
end
