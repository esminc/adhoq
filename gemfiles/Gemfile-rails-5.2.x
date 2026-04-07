source 'https://rubygems.org'

gemspec path: '..'

gem 'rails', '~> 5.2.0'

# The following gems have required_ruby_version >= 2.5 but Ruby 2.4's RubyGems
# has a bug that ignores required_ruby_version, so we pin explicitly.
if RUBY_VERSION < '2.5'
  gem 'sqlite3', '~> 1.4.0'
  gem 'loofah', '< 2.19'                   # 2.19+ uses Nokogiri::HTML4 (needs Nokogiri >= 1.13)
  gem 'rails-html-sanitizer', '~> 1.4.3'  # 1.4.4+ requires loofah >= 2.19
  gem 'simple_xlsx_reader', '~> 1.0'       # 2.x+ uses Struct keyword_init: (Ruby 2.5+)
  gem 'puma', '~> 4.0'                     # puma 5+ requires Ruby >= 2.5
end
