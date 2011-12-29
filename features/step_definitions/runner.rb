When /^I generate a `Specdown::Runner` instance from it:$/ do |string|
  eval string
end

Then /^I should be able to run the tests:$/ do |string|
  eval string
end

Then /^I should be able to print a report:$/ do |string|
  eval string
end

Then /^I should be able to access the report data programatically:$/ do |string|
  eval string
end
