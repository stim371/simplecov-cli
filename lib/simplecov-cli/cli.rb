# require 'simplecov-cli'
require 'optparse'

module SimplecovCLI
  class Cli
    def self.run(args, out = STDOUT)
      
      exit 1 if args.empty?
      
      OptionParser.new{ |opts|
        opts.banner = "Usage:\n   simplecov-cli [options] <repository url>"
        opts.separator "\nOptions: "
        
        opts.on_tail("-v", "--version", "Print the version number") do
          require "simplecov-cli/version"
          out << "Simplecov-cli #{SimplecovCLI::VERSION}\n"
          exit
        end
      }.parse!(args)
      
      # out << SimplecovCLI.check_coverage(args)
      exit 0
    end
  end
end