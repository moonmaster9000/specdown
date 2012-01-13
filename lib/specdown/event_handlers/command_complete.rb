Specdown::EventServer.register :command_complete do |results|
  Specdown.reporter.print_summary(results)
  Specdown.reporter.print_end
end
