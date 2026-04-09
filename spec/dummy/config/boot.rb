# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../../../Gemfile', __FILE__)

require 'bundler/setup' if File.exist?(ENV['BUNDLE_GEMFILE'])
require 'logger'  # Ensure Logger constant is defined before Rails loads (logger gem shadows stdlib autoload)
$LOAD_PATH.unshift File.expand_path('../../../../lib', __FILE__)
