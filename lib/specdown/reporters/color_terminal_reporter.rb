module Specdown
  class ColorTerminalReporter < TerminalReporter
    def success
      Term::ANSIColor.green super
    end

    def failure
      Term::ANSIColor.red(Term::ANSIColor.bold super)
    end

    def success
      Term::ANSIColor.blue super
    end

    private
    def template
      ERB.new File.read(File.join(File.dirname(__FILE__), "../templates/color_summary.erb"))
    end
  end
end
