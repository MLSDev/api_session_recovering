[![Maintainability](https://api.codeclimate.com/v1/badges/febb3376c6586f609650/maintainability)](https://codeclimate.com/github/DmytroStepaniuk/api_session_recovering/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/febb3376c6586f609650/test_coverage)](https://codeclimate.com/github/DmytroStepaniuk/api_session_recovering/test_coverage)
[![Build Status](https://travis-ci.org/DmytroStepaniuk/api_session_recovering.svg?branch=master)](https://travis-ci.org/DmytroStepaniuk/api_session_recovering)
[![Dependency Status](https://gemnasium.com/badges/github.com/DmytroStepaniuk/api_session_recovering.svg)](https://gemnasium.com/github.com/DmytroStepaniuk/api_session_recovering)

# ApiSessionRecovering

ApiSessionRecovering.

Only Rails `~> 5` support.

## Installation

Add these gems to your Gemfile

``` ruby
gem 'api_session_recovering'

gem 'geocoder'
```

...and run `bundle install` to install the gems.

Next, run:

``` bash
# add an initializer to config/initializers with all of the configuration options
rails g api_session_recovering:install

# This will add the necessary migrations to your app's db/migrate directory
rails api_session_recovering:install:migrations

# This will run any pending migrations
rails db:migrate
```

then add the following to your routes.rb file:

``` bash
# config/routes.rb
mount ApiSessionRecovering::Engine => '/api'

# or inside api namespace

namespace :api do
  mount ApiSessionRecovering::Engine => '/'
end
```

It will generate routes like

```
Routes for ApiSessionRecovering::Engine:
  session_recovering_restore_password            POST /session_recovering/restore_password(.:format)
  session_recovering_reset_password_validation   POST /session_recovering/reset_passwords/validate(.:format)
  session_recovering_reset_password              POST /session_recovering/reset_password(.:format)
```
