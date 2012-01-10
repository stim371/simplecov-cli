#!/usr/bin/env ruby

remote_repo = ARGV[0]

list = %x[gem list]
repo_name = remote_repo.split("/")[-1].match(/(.*)\.git/)[1]
puts "the repo name is: #{repo_name}"
unless list.scan /^simplecov /
  puts "installing simplecov..."
  %x[gem install simplecov]
else
  puts "you already have simplecov!"
end

puts "cloning remote repo..."
# %x[git clone "#{remote_repo}"]

# %x[cd ]
# puts ""