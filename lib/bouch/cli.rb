require 'bouch'
require 'bouch/version'

class Bouch
  # Parse the command line
  class CLI
    attr_accessor :yaml_file

    def initialize(file)
      @yaml_file = file
    end

    def start
      if @yaml_file.eql?(nil)
        puts 'Please supply budget pouch YAML file path and rerun bouch.'
        usage
      elsif File.exist?(@yaml_file)
        budget = Bouch.new(@yaml_file)
        budget.show_budget
      else
        puts "Whoops. The budget pouch file specified: #{@yaml_file} ; does not exist!"
        usage
      end
    end

    def usage
      puts "<<bouch #{Bouch::VERSION}>>\nUsage: #{File.basename($PROGRAM_NAME)} [YAML_FILE]"
    end
  end
end
