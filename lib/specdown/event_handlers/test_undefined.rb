Specdown::EventServer.register :test_undefined do |test|
  Specdown.reporter.print_undefined nil
end
