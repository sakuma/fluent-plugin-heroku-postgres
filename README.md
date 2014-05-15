# Fluentd Plugin for Heroku Postgres

td-agent on Heroku.

## Installation

Add this line to your application's Gemfile:

    gem 'fluent-plugin-heroku-postgres'

And then execute:

    $ bundle

## Usage

* example

### td-agent-conf.rb

※  Not 'td-agent.conf'

```ruby
# td-agent-conf.rb

match('postgres.**') {
  type :heroku_postgres

  heroku_postgres_url "#{::ENV['DATABASE_URL']}"
  key_names 'name'
  sql "INSERT INTO vendors (name) VALUES ($1)"
}
```

### Procfile

```
web: bundle exec fluentd -c td-agent-conf.rb -i "source { type :http; port $PORT }" -vv
```

## Option

### Basic Authentication

* Using ":basic_auth_http" source type

```
# Procfile
web: bundle exec fluentd -c td-agent-conf.rb -i "source { type :basic_auth_http; port $PORT }" -vv
```

* Set ENV on Heroku config

USERNAME=name
PASSWORD=passwd


## Contributing

1. Fork it ( http://github.com/<my-github-username>/fluent-plugin-heroku-postgres/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
