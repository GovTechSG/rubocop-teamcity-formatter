# rubocop-teamcity-formatter
[![Build Status](https://travis-ci.org/govtechsg/rubocop-teamcity-formatter.svg?branch=master)](https://travis-ci.org/govtechsg/rubocop-teamcity-formatter)
Report RuboCop offences as TeamCity Service Messages

## Usage
Add to `Gemfile`, for example:

```ruby
group :development do
  gem 'rubocop-teamcity-formatter', git: 'https://github.com/govtechsg/rubocop-teamcity-formatter.git', require: false
end

```

When running `rubocop` for Teamcity:

```bash
TEAMCITY_FMT_PATH="`bundle show rubocop-teamcity-formatter`/lib/rubocop/formatter/teamcity-formatter.rb"
bundle exec rubocop -r ${TEAMCITY_FMT_PATH} --format RuboCop::Formatter::TeamCityFormatter
```

## Contributing
See [CONTRIBUTING.md](https://github.com/govtechsg/rubocop-teamcity-formatter/blob/master/CONTRIBUTING.md) for how to send issues and pull requests
