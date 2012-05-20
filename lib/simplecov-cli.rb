module SimplecovCLI
  extend self
  
  def check_coverage(repo_url)
    # set up values needed
    local_gem_list = %x[gem list]
    repo_name = repo_url.match(/.*\/(.*[^\.git])/)[1]
    puts "the repo name is: #{repo_name}"

    clone_repository(repo_url)

    # change into the project directory
    base_path = Dir.pwd + "/"
    repo_path = base_path + repo_name
    puts "switching to #{repo_path}"
    Dir.chdir(repo_path)

    create_simplecov_file

    install_simplecov(local_gem_list)

    install_repository_dependencies

    add_simplecov_triggers_to_test_helpers

    run_tests

    open_coverage_report

    sleep 2
    
    # switch back to main dir
    # TODO: switch calls to stay in the main dir so you dont have to chdir back and forth
    Dir.chdir(base_path)

    # clean_up(repo_name)
  end
  
  private
  
  def clone_repository(repo)
    puts "cloning remote repo..."
    %x[git clone "#{repo}"]
  end
  
  def create_simplecov_file
    puts "creating simplecov file"
    File.open(".simplecov", "w") do |r|
      r.syswrite("SimpleCov.start")
    end
  end
  
  def install_simplecov(local_gem_list)
    if local_gem_list.scan /^simplecov /
      puts "you already have simplecov!"
    else
      puts "installing simplecov..."
      %x[gem install simplecov]
    end
  end
  
  def install_repository_dependencies
    puts "running bundler!"
    %x[bundle]
  end
  
  def add_simplecov_triggers_to_test_helpers
    # update this to match with the new method where we add a .simplecov file instead of adding it over and over
    # for each of the three test files (are there others?)
    #   spec/spec_helper.rb
    #   test/test_helper.rb
    #   features/env.rb
    # append 'Simplecov.start' IF THE FILE EXISTS
    file_redirect = ""
    
    %w[spec test].each do |suite|
      if File.exists?(suite)
        if File.file?("#{suite}/#{suite}_helper.rb")
          %x[mv -f #{suite}/#{suite}_helper.rb #{suite}/sc_temp_helper.rb]
          file_redirect = "require_relative 'sc_temp_helper'"
        end
        File.open("#{suite}/#{suite}_helper.rb", "w") do |r|
          r.syswrite("require 'simplecov'\n#{file_redirect}")
        end
        puts "modified #{suite}_helper"
      end
    end

    if File.exists?("features")
      contents = File.open("features/env.rb", "r").read
      File.open("features/env.rb", "w") do |r|
        r.syswrite("require 'simplecov'\n" + contents)
      end
      puts "modified cucumber env"
    end
  end
  
  def run_tests
    #TODO: need to include other test packages.
    #maybe a rake task based on the directories found above?
    puts "running tests"
    %x[rspec]
  end
  
  def open_coverage_report
    puts "opening coverage report"
    %x[open "coverage/index.html"]
  end
  
  def clean_up(repo_name)
    puts "cleaning up!"
    %x[rm -rf #{repo_name}/]
  end
end
