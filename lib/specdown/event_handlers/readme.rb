Specdown::Readme.hook_before(:execute) do |readme|
  Specdown.reporter.print_readme_start readme if Specdown::Config.format == :condensed
end

Specdown::Readme.hook_after(:execute) do |readme|
  Specdown.reporter.print_readme_end readme if Specdown::Config.format == :condensed
end
