module Specdown
  module OptionParser
    extend self

    def parse!
      parser.parse!
      Specdown::Config.tests = ARGV
    end

    private
    def parser
      ::OptionParser.new do |opts|
        opts.banner = "Usage: specdown -h | specdown [FILE|DIR]+ [-r]"

        opts.on '-r', '--root SPECDOWN_DIR', 'defaults to ./specdown' do |root|
          Specdown::Config.root = root
        end

        opts.on '-h', '--help', 'Display this screen'  do
          puts opts
          exit
        end
      end
    end
  end
end
