#!/usr/bin/env ruby

# set up values needed
remote_repo = ARGV[0]
list = %x[gem list]
repo_name = remote_repo.match(/.*\/(.*)\.git/)[1]
puts "the repo name is: #{repo_name}"

# clone repo from github
puts "cloning remote repo..."
%x[git clone "#{remote_repo}"]

# change into the project directory
base_path = Dir.pwd + "/" + repo_name
puts "switching to #{base_path}"
Dir.chdir(base_path)

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

# for each of the three test files (are there others?)
#   spec/spec_helper.rb
#   test/test_helper.rb
#   features/env.rb
# append 'Simplecov.' IF THE FILE EXISTS

%w[spec test].each do |suite|
  if File.exists? suite
    contents = File.open("#{suite}/#{suite}_helper.rb", "r").read
    File.open("#{suite}/#{suite}_helper.rb", "w") do |r|
      r.syswrite("require 'simplecov'\n" + contents)
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
Dir.chdir("coverage")
%x[open "index.html"]
