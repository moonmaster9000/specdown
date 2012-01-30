Specdown::Readme.before_execute do |readme|
  Specdown.reporter.print_readme_start readme if Specdown::Config.format == :condensed
end

Specdown::Readme.after_execute do |readme|
  Specdown.reporter.print_readme_end readme if Specdown::Config.format == :condensed
end
