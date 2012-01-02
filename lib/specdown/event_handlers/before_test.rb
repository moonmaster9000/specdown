Specdown::EventServer.register :before_test do |runner|
  Specdown::Hooks.matching_before_hooks(runner.file_name).map &:call
  Specdown::Hooks.matching_around_hooks(runner.file_name).map &:call
end
