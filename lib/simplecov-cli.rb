module SimplecovCLI
  extend self
  
  def check_coverage repo_url
    # set up values
    # clone repo from github
    # switch into project directory
    # create .simplecov file
    # install simplecov gem
      # if not installed
    # install dependencies
    # put require statements in test helper files
      # test, spec, features
    # run tests
    # open coverage report
    # clean up?
      # use options parser to decide whether to clean up
  end
end


# set up values needed
remote_repo = ARGV[0]
list = %x[gem list]
repo_name = remote_repo.match(/.*\/(.*[^\.git])/)[1]
puts "the repo name is: #{repo_name}"

# clone repo from github
puts "cloning remote repo..."
%x[git clone "#{remote_repo}"]

# change into the project directory
base_path = Dir.pwd + "/"
repo_path = base_path + repo_name
puts "switching to #{repo_path}"
Dir.chdir(repo_path)

# create .simplecov file
File.open(".simplecov", "w") do |r|
  r.syswrite("SimpleCov.start")
end

# install the gem if you don't have it already
unless list.scan /^simplecov /
  puts "installing simplecov..."
  %x[gem install simplecov]
else
  puts "you already have simplecov!"
end

# get all dependencies for project
puts "running bundler!"
%x[bundle]

  # update this to match with the new method where we ad a .simplecov file instead of adding it over and over
# for each of the three test files (are there others?)
#   spec/spec_helper.rb
#   test/test_helper.rb
#   features/env.rb
# append 'Simplecov.start' IF THE FILE EXISTS

%w[spec test].each do |suite|
  if File.exists? suite
    if File.file? "#{suite}/#{suite}_helper.rb"
      %x[mv -f #{suite}/#{suite}_helper.rb #{suite}/sc_temp_helper.rb]
    end
      File.open("#{suite}/#{suite}_helper.rb", "w") do |r|
        r.syswrite("require 'simplecov'\nrequire_relative 'sc_temp_helper'")
      end
    puts "modified #{suite}_helper"
  end
end

if File.exists? "features"
  contents = File.open("features/env.rb", "r").read
  File.open("features/env.rb", "w") do |r|
    r.syswrite("require 'simplecov'\n" + contents)
  end
  puts "modified cucumber env"
end

puts "running tests"
%x[rspec]

puts "opening coverage report"
%x[open "coverage/index.html"]

sleep 2

Dir.chdir(base_path)

puts "cleaning up!"
%x[rm -rf #{repo_name}/]
