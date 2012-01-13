Specdown::EventServer.register :run_started do |runner|
  Specdown.reporter.print_runner_start runner if Specdown::Config.format == :condensed
end
