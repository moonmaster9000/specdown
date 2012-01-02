Specdown::EventServer.register :after_test do |runner|
  Specdown::Hooks.matching_after_hooks(runner.file_name).map  &:call
  Specdown::Hooks.matching_around_hooks(runner.file_name).map &:call
end
