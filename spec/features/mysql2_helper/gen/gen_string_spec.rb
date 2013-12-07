require_relative "../../../../lib/mysql2_helper/gen/gen_string"

describe GenString do
  
  describe "enclose" do
    describe "enclose_with_paren" do
      it "nil" do
        params = nil
        result = GenString.enclose_with_paren(params)
        expect(result).to eq(nil)
      end
      
      it "foo" do
        params = "foo"
        result = GenString.enclose_with_paren(params)
        expect(result).to eq("\(foo\)")
      end
    end
  end
  
  describe "array to string" do
    describe "array_to_comma_str" do
      it "nil" do
        params = nil
        result = GenString.array_to_comma_str(params)
        expect(result).to eq(nil)
      end
      
      it "foo" do
        params = ["foo"]
        result = GenString.array_to_comma_str(params)
        expect(result).to eq("foo")
      end
      
      it "foo bar baz" do
        params = ["foo", "bar", "baz"]
        result = GenString.array_to_comma_str(params)
        expect(result).to eq("foo, bar, baz")
      end
    end
  end
  
end