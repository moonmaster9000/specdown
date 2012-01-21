Given /^the following implicit specification:$/ do |string|
  eval string
end

When /^I parse it with the implicit parser:$/ do |string|
  eval string
end

Then /^I should receive a hash lookup of implicit definitions:$/ do |string|
  eval string
end

Given /^two implicit specification strings:$/ do |string|
  eval string
end

When /^I pass both off to the Specdown::ImplicitParser:$/ do |string|
  eval string
end
