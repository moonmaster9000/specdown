Given /^the following markdown with a pending spec:$/ do |string|
  @directory = "features/specdown_examples/pending_specs/"
end

Then /^the `specdown` command should return the following output:$/ do |string|
  ensure_included! string, bundle_exec!("specdown") 
end
