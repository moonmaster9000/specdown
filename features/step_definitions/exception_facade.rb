
Given /^the following exception:$/ do |string|
  eval string
end

Given /^the following fake runner:$/ do |string|
  eval string
end

When /^I generate an exception facade:$/ do |string|
  eval string
end

Then /^it should return all kinds of information about the exception and it's context:$/ do |string|
  eval string
end
