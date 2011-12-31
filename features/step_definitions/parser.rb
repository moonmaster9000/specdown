Given /^the following specdown example file.*:$/ do |string|
  @readme = File.read "features/fixtures/parser_example.markdown"
end

When /^I parse it into a tree:$/ do |string|
  eval string
end

Then /^the root should be the ".*" section:$/ do |string|
  eval string
end

Then /^the root should have two children:$/ do |string|
  eval string
end
