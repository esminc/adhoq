Adhoq [![Build Status](https://travis-ci.org/esminc/adhoq.svg)](https://travis-ci.org/esminc/adhoq) [![Code Climate](https://codeclimate.com/github/esminc/adhoq/badges/gpa.svg)](https://codeclimate.com/github/esminc/adhoq)
====

Rails engine to generate instant reports from adhoc SQL query.

![adhoq](https://cloud.githubusercontent.com/assets/3419/4556639/7f06340a-4ecb-11e4-87c4-b074580e77f5.png)

## Features

- [x] Rails 4.x support
- [x] Rails 3.2 support
- Export reports in some formats:
  - [x] .xlsx
  - [ ] .csv
  - [ ] .json
- Report storage supports (based on `Fog::Storage`):
  - [x] Local File
  - [x] S3
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
  config.storage       = [:local_file, Rails.root + './path/to/store/report/files']
  config.authorization = ->(controller) { controller.signed_in? }
end
```

See configuration example in [dummy app](https://github.com/esminc/adhoq/blob/master/spec/dummy/config/initializers/adhoq.rb).

Then restart server and try it out.

### As Plain old library (application export helper)

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/esminc/adhoq/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
