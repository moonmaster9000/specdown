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

        opts.on '-f', '--format plain|color', 'defaults to "color"' do |format|
          case format
            when 'plain' then Specdown::Config.reporter = Specdown::TerminalReporter
            when 'color' then Specdown::Config.reporter = Specdown::ColorTerminalReporter
          end
        end

        opts.on_tail '-h', '--help', 'Display this screen'  do
          puts opts
          exit
        end

        opts.on_tail "-v", "--version", "Show version" do
          puts File.read(File.join(File.dirname(__FILE__), "../../../VERSION"))
          exit
        end
      end
    end
  end
end
