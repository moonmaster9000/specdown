Given /^the following module:$/ do |string|
  eval string
end

When /^I decorate the sandbox with it:$/ do |string|
  eval string
end

Then /^all sandboxes should include my module methods:$/ do |string|
  eval string
end
