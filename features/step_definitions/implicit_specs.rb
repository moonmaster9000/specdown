Given /^a markdown file with an implicit spec:$/ do |string|
end

Given /^no implicit specification$/ do
  @directory = "features/specdown_examples/no_implicit/"
end

When /^I run the `specdown` command$/ do
  @output = bundle_exec! "specdown"
end

Given /^a specdown file with a pending specification:$/ do |string|
  @directory = "features/specdown_examples/pending_implicit/"
end

Given /^a specdown file with a complete specification:$/ do |string|
  @directory = "features/specdown_examples/complete_implicit/"
end
