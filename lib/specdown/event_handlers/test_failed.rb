Specdown::EventServer.register :test_failed do
  Specdown.reporter.print_failure nil
end
