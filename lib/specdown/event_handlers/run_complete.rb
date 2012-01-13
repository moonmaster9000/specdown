Specdown::EventServer.register :run_complete do |runner|
  Specdown.reporter.print_runner_end runner if Specdown::Config.format == :condensed
end
