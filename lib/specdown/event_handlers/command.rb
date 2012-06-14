Specdown::Command.hook_after(:execute) do |command|
  Specdown.reporter.print_summary command.readmes
  Specdown.reporter.print_end
end
