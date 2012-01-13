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

        opts.on '-c', '--colorized', 'Colorize the terminal output' do
          Specdown::Config.reporter = Specdown::ColorTerminalReporter
        end

        opts.on '-n', '--non-colorized', 'Display plain terminal output' do
          Specdown::Config.reporter = Specdown::TerminalReporter
        end

        opts.on_tail '-h', '--help', 'Display this screen'  do
          puts opts
          exit
        end

        opts.on '-o', '--output=OUTPUT', ["text", "terminal"], 'output to either the terminal or a text file "specdown_report.txt". Defaults to terminal.' do |output_format|
          case output_format
            when "text"     then Specdown::Config.reporter = Specdown::TextReporter
            when "terminal" then Specdown::Config.reporter = Specdown::ColorTerminalReporter
          end
        end

        opts.on '-f', '--format=FORMAT', [:short, :condensed], 'length and style of output.' do |format|
          Specdown::Config.format = format
        end

        opts.on_tail "-v", "--version", "Show version" do
          puts File.read(File.join(File.dirname(__FILE__), "../../../VERSION"))
          exit
        end
      end
    end
  end
end
