# require 'simplecov-cli'

module SimplecovCLI
  class Cli
    def self.run(args, out = STDOUT)
      
      exit 1 if args.empty?
      
      out << check_coverage(args)
      exit 0
    end
  end
end