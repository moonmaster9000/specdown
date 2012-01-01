Given /^I have configured Specdown:$/ do |string|
  eval string
end

When /^I reset Specdown:$/ do |string|
  eval string
end

Then /^my specdown configuration should return to it's defaults:$/ do |string|
  eval string
end

Given /^I have rspec installed$/ do
end

Then /^Specdown should provide rspec expectations and matchers within the sandbox by default:$/ do |string|
  eval string
end

Given /^I have manually configured Specdown to use Rspec expectations:$/ do |string|
  eval string
end

Then /^Specdown should provide rspec expectations and matchers within the sandbox:$/ do |string|
  eval string
end

Given /^I have manually configured Specdown to use Test::Unit assertions:$/ do |string|
  eval string
end

Then /^Specdown should provide Test::Unit assertions within the sandbox:$/ do |string|
  eval string
end
