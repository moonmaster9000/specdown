Given /^a USA population of zero:$/ do |string|
  eval string
end

Given /^a world population of .*:$/ do |string|
  eval string
end

Given /^I register callbacks to increment both whenever someone is born:$/ do |string|
  eval string
end

When /^I create a ".*" event:$/ do |string|
  eval string
end

Then /^both the USA population and the World population should increase:$/ do |string|
  eval string
end
