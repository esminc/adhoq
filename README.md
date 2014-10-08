# Adhoq

Rails engine to generate instant reports from adhoc SQL query.

## Features

- [x] Rails 4.x support
- [ ] Rails 3.2 support
- Export reports in some formats:
  - [x] .xlsx
  - [ ] .csv
  - [ ] .json
- Report storage supports:
  - [x] as local file
  - [ ] S3 (via `Fog::Storage`)
- [ ] In application export function helper

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'adhoq'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install adhoq

## Usage

### As Rails engine

Install migrations

```sh
$ bundle exec rake adhoq:install:migrations
$ bundle exec rake db:migrate
```

Mount it in `config/routes.rb`

```ruby
Rails.application.routes.draw do
  root  to: 'hi#show'

  mount Adhoq::Engine => "/adhoq"
end
```

Edit initialization file in `config/initializer/adhoq.rb`

```ruby
Adhoq.configure do |config|
  config.storage       = [:local_file, Rails.root + '/path/to/store/report/files']
  config.authorization = ->(controller) { controller.signed_in? }
end
```

Then restart server and try it out.

### As Plain old library (application export helper)

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/[my-github-username]/adhoq/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
