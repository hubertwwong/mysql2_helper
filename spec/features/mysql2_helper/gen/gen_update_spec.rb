require_relative "../../../../lib/mysql2_helper/gen/gen_update"

describe GenUpdate do
  
  describe "update_multi" do
    it "basic" do
      params = {:tbl_ref => "foo a, bar b",
                :set_ref => "a.name=b.name"}
      final_str = "UPDATE foo a, bar b SET a.name=b.name;"
      
      result = GenUpdate.update_multi params
      expect(result).to eq(final_str)
    end
  end
  
end