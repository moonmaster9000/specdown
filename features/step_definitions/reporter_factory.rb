Given /^that I want a non\-colorized text output report:$/ do |string|
  eval string
end

Then /^`Specdown::ReporterFactory\.generate` should return a undecorated `Specdown::Reporter`:$/ do |string|
  eval string
end

Given /^that I want a colorized Specdown::Reporter:$/ do |string|
  eval string
end

Then /^`Specdown::ReporterFactory\.generate` should return a `Specdown::Reporter` decorated with `Specdown::AnsiColor`$/ do |string|
  eval string
end

Given /^that I want an html report:$/ do |string|
  eval string
end

Then /^`Specdown::ReporterFactory\.generate` should return a `Specdown::Reporter` decorated with `Specdown::HtmlReporter`$/ do |string|
  eval string
end

Given /^I have added the following decorator to `Specdown::ReporterFactory`:$/ do |string|
  eval string
end

Then /^reporters should be decorated with my new decorator:$/ do |string|
  eval string
end

Then /^`Specdown::ReporterFactory\.generate` should return a `Specdown::Reporter` decorated with `Specdown::TerminalReporter`:$/ do |string|
  eval string
end

Then /^`Specdown::ReporterFactory\.generate` should return a `Specdown::Reporter` decorated with `Specdown::TerminalReporter` and `Specdown::ColorTerminalReporter`:$/ do |string|
  eval string
end
