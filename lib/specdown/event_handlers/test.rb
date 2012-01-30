Specdown::Test.after_execute do |test|
  case test.status
    when :passing   then Specdown.reporter.print_success   test
    when :failing   then Specdown.reporter.print_failure   test
    when :undefined then Specdown.reporter.print_undefined test
    when :pending   then Specdown.reporter.print_pending   test
  end
end
