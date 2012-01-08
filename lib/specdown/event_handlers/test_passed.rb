Specdown::EventServer.register :test_passed do
  Specdown.reporter.print_success nil
end
