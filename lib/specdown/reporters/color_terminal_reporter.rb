module Specdown
  class ColorTerminalReporter < TerminalReporter
    def success
      Term::ANSIColor.green super
    end

    def failure
      Term::ANSIColor.red(Term::ANSIColor.bold super)
    end

    def undefined
      Term::ANSIColor.yellow super
    end

    def print_readme_start(readme)
      print Term::ANSIColor.bold("#{readme.file_name}: ")
    end

    private
    def template
      ERB.new File.read(File.join(File.dirname(__FILE__), "../templates/color_summary.erb"))
    end
  end
end
