Adhoq [![Build Status](https://travis-ci.org/esminc/adhoq.svg)](https://travis-ci.org/esminc/adhoq) [![Code Climate](https://codeclimate.com/github/esminc/adhoq/badges/gpa.svg)](https://codeclimate.com/github/esminc/adhoq) [![Test Coverage](https://codeclimate.com/github/esminc/adhoq/badges/coverage.svg)](https://codeclimate.com/github/esminc/adhoq/coverage)
====

Rails engine to generate instant reports from adhoc SQL query.

![adhoq](https://cloud.githubusercontent.com/assets/3419/4556639/7f06340a-4ecb-11e4-87c4-b074580e77f5.png)

## Features

- Export ad-hoc SQL reports in some formats:
  - .csv
  - .json
  - .xlsx
- Persist generated report as local file or in AWS S3
- over Rails 5.1.X
- Nice administration console with rails engine

### Future planning

- [ ] Label data substitution

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

Edit initialization file in `config/initializers/adhoq.rb`

```ruby
Adhoq.configure do |config|
  # if not set, use :on_the_fly.(default)
  config.storage       = [:local_file, Rails.root + './path/to/store/report/files']
  config.authorization = ->(controller) { controller.signed_in? }
end
```

See configuration example in [dummy app](https://github.com/esminc/adhoq/blob/master/spec/dummy/config/initializers/adhoq.rb).

Then restart server and try it out.

### As Plain old library (application export helper)

Adhoq also provides report generation from SQL string, not from mounted rails engine.

```ruby
execution = Adhoq::AdhocExecution.new(
  'xlsx',
  'SELECT "hello" AS name ,"English greeting message" AS description'
)

Adhoq::Reporter.generate(execution) #=> report data
```

Persistence is also available without engine via `Adhoq::Storage::SomeClass#store`.
Below is example that generating report and persist to in Rails application report method.

```ruby
execution = Adhoq::AdhocExecution.new(
  'xlsx',
  'SELECT "hello" AS name ,"English greeting message" AS description'
)

storage   = Storage::S3.new(
  'my-adhoq-bucket',
  aws_access_key_id: 'key_id',
  aws_secret_access_key: 'access_key'
)

# generate report and store it to S3, returns `key` to get report data
key = storage.store('.xlsx') { Adhoq::Reporter.generate(execution) }

...
storage.get(key) #=> report data
```

###Query Parameters
A query may contain parameters that can be substitued in at run time. Parameters are identified with a $ prefix for 
string parameters and $ prefix with curly brackets for number parameters, for example :

```sql
SELECT * FROM users where created_at > '$time' AND activated = ${activated}
```

Parameters are shown as input fields in the engine UI in the Create Report section below the query. Note that currently
if the same parameter is used more than once in the query there is an input field for each occurance in the query, rather than
one input being substituted multiple times. 

Parameters can also be manipluated programatically. For example the following code shows how you might use parameters
in an API type situation. The index method returns all queries as JSON with the parameters extracted and added as a separate 
property. Note that the query.parameters method actually extracts the parameters from the query on the fly rather than 
being a simple Getter for a parameters property, hence the need to add it into the as_json variable.

The associated show method substitutes in any query parameters passed in and runs the report. The line 

    sub = params.permit(*query.parameters).to_hash

uses the query's paramenters as a white list against any passed in params, which are then stored as a hash to be used
in the subsequent substitute_query call.

```ruby
class AdminApi::ReportsController < AdminApi::BaseController
  def index
    respond_to do |format|
      @output = []
      ah_queries = Adhoq::Query.all
      ah_queries.each do |ah_query|
        j_query = ah_query.as_json
        j_query['params'] = ah_query.parameters
        @output.push(j_query)
      end
      format.html { render json: @output }
      format.json { render json: @output }
    end
  end

  def show
    query = Adhoq::Query.find(params[:id])
    sub = params.permit(*query.parameters).to_hash
    substituted_query = query.substitute_query(sub)
    execution = Adhoq::AdhocExecution.new(
        'csv',
        substituted_query
    )
    report = (Adhoq::Reporter.generate(execution))
    send_file report
  end
end
```
## Contributing

1. Fork it ( https://github.com/esminc/adhoq/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
