require 'bouch'

class Bouch
  # Parse the command line
  class CLI
    YAML_FILE = ARGV[0].freeze

    def start
      if YAML_FILE.eql?(nil)
        puts 'Please supply budget pouch YAML file path and rerun bouch.'
        usage
      elsif File.exists?(YAML_FILE)
        budget = Bouch.new(YAML_FILE)
        budget.show_budget
      else
        puts "Whoops. The budget pouch file specified: #{YAML_FILE} ; does not exist!"
        usage
        exit 1
      end
    end

    def usage
      puts "Usage: #{File.basename($PROGRAM_NAME)} [YAML_FILE]"
    end
  end
end
