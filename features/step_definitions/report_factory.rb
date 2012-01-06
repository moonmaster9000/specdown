Given /^that I want a non\-colorized text output report:$/ do |string|
  eval string
end

Then /^`Specdown::ReportFactory\.generate` should return a non\-decorated `Specdown::Report`:$/ do |string|
  eval string
end

Given /^that I want a colorized Specdown::Report:$/ do |string|
  eval string
end

Then /^`Specdown::ReportFactory\.generate` should return a `Specdown::Report` decorated with `Specdown::AnsiColor`$/ do |string|
  eval string
end

Given /^that I want an html report:$/ do |string|
  eval string
end

Then /^`Specdown::ReportFactory\.generate` should return a `Specdown::Report` decorated with `Specdown::HtmlReport`$/ do |string|
  eval string
end
