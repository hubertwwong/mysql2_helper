require_relative "../../lib/mysql2_helper"

describe Mysql2Helper do
  
  describe "hello" do
    it "should return hello" do
      ms = Mysql2Helper.new
      expect(ms.hello).to eq('hello')
    end
  end
  
end