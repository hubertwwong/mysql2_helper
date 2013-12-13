# A sample Guardfile
# More info at https://github.com/guard/guard#readme

# modified gem....
guard :rspec do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }
end

# this i think starts all test cases on initial launch.
guard :rspec, :all_on_start => true