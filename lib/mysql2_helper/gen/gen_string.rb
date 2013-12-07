# some generic string generating functions.
# stuff like create a string from a array of strings.
class GenString
  
  # compond func.
  ############################################################################
  
  
  
  # enclosing strings.
  ############################################################################
  
  # encloses a string with a open and close parenthese.
  def self.enclose_with_paren(some_str)
    if some_str != nil
      return "\(" + some_str.to_s + "\)"
    else
      return nil
    end
  end
  
  # convert array to string
  ############################################################################
  
  # covert an array of strings to a comma string.
  # 
  # so....
  # input:
  # ["foo", "bar", "baz"]
  # output:
  # "foo, bar, baz"
  def self.array_to_comma_str(array_params)
    if array_params == nil
      return nil
    elsif array_params.length == 1
      return array_params[0]
    elsif array_params.length > 0
      # load first param.
      final_str = array_params[0]
      
      # load other strings.
      array_params.each_with_index do |array_param, i|
        # skip the first item since you used it already.
        if i != 0
          final_str = final_str + ", " + array_param
        end
      end
      
      # return it.
      return final_str
    end
    
    # if it fails the param checks,
    # return nil. user didn't enter a correct value.
    return nil
  end
   
end