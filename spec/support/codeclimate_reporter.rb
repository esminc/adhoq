if ENV['CODECLIMATE_REPO_TOKEN'] && RUBY_VERSION >= '2.1'
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
end
