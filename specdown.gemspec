Gem::Specification.new do |s|
  s.name      = "specdown"
  s.author    = "Matt Parker"
  s.email     = "moonmaster9000@gmail.com"
  s.summary   = "Write your specs as if they were a README, then EXECUTE them."
  s.homepage  = "http://github.com/moonmaster9000/specdown"
  s.version   = File.read "VERSION"

  s.files             = Dir["lib/**/*"] + Dir["bin/**/*"]
  s.test_files        = Dir["features/**/*"]
  s.extra_rdoc_files  = Dir["*.markdown"]
  s.executables << "specdown"

  s.add_dependency "kramdown", "~> 0.13.4"
  s.add_dependency "term-ansicolor", "~> 1.0.7"
  
  s.add_development_dependency "cucumber"
  s.add_development_dependency "rspec"
end
