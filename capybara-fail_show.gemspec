Gem::Specification.new do |s|
  s.name        = 'capybara-fail_show'
  s.version     = '0.1.2'
  s.date        = '2016-11-29'
  s.summary     = "Show capybara feature fails in the browser"
  s.description = "When a feature fails, the browser opens the page where the test failed and shows the error."
  s.authors     = ["Robert Johansson"]
  s.email       = 'robert@competic.se'
  s.files       = ["lib/capybara/fail_show.rb"]
  s.license       = 'MIT'

  s.add_runtime_dependency 'launchy'
  s.add_runtime_dependency 'rspec-rails', '>= 3.0' # But sort of needs to be called from the spec helper so hard to avoid it
  s.add_runtime_dependency 'capybara'
end
