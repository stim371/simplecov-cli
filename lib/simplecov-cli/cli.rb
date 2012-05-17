# require 'simplecov-cli'
require 'optparse'

module SimplecovCLI
  class Cli
    def self.run(args, out = STDOUT)
      
      exit 1 if args.empty?
      
      OptionParser.new{ |opts|
        opts.banner = "Usage:\n   simplecov-cli [options] <repository url>"
        opts.separator "\nOptions: "
        
        #TODO: option to not clean up after itself
        
        opts.on_tail("-v", "--version", "Show version") do
          require "simplecov-cli/version"
          out << "Simplecov-cli #{SimplecovCLI::VERSION}\n"
          exit
        end
        
        opts.on_tail("-h", "--help", "Print the help") do
          out << "Pull code test coverage reports straight from the command line.\n\n"
          out << "CLI wrapper created and maintained by Joel Stimson.\n"
          out << "Report bugs and contribute at http://github.com/stim371/simplecov-cli\n\n"
          out << "The simplecov gem is maintained separately by colszowka.\n"
          out << "Report bugs and contribute at http://github.com/colszowka/simplecov\n"
        end
      }.parse!(args)
      
      # out << SimplecovCLI.check_coverage(args)
      exit 0
    end
  end
end