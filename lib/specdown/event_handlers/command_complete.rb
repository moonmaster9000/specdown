Specdown::EventServer.register :command_complete do |results|
  Specdown.reporter.print_summary(results)
end
