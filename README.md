[![Maintainability](https://api.codeclimate.com/v1/badges/febb3376c6586f609650/maintainability)](https://codeclimate.com/github/DmytroStepaniuk/api_session_recovering/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/febb3376c6586f609650/test_coverage)](https://codeclimate.com/github/DmytroStepaniuk/api_session_recovering/test_coverage)
[![Build Status](https://travis-ci.org/MLSDev/api_session_recovering.svg?branch=master)](https://travis-ci.org/MLSDev/api_session_recovering)

# ApiSessionRecovering

`ApiSessionRecovering`.

Only Rails `> 5` support.

## Installation

Add these gems to your Gemfile

``` ruby
gem 'api_session_recovering', github: 'MLSDev/api_session_recovering', tag: 'v0.1.1'

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

### Request params

- POST /session_recovering/restore_password(.:format)

```json
{
  "restore_password": {
    "frontend_path": ...,
    "email":         ...
  }
}
```

OR

```json
{
  "restore_password": {
    "frontend_path": ...,
    "phone":         ...
  }
}
```

- POST /session_recovering/reset_passwords/validate(.:format)

```json
{
  "email": ...,
  "token": ...
}
```

- POST /session_recovering/reset_password(.:format)


```javascript
{
  "reset_password": {
    "token": ...,
    "password": ...,
    "password_confirmation": ...,
    "email": ...                     // token should be unique in scope of email (security reasons)
  }
}
```


### SWAGGER

Add in SWAGGERED_CLASSES array in api docs controller of project (if swagger gem is used in project)

`ApiSessionRecovering::SWAGGER_CLASSES`

And call on array `flatten` method like this

```
SWAGGERED_CLASSES = [
    SomeClass,
    ApiSessionRecovering::SWAGGER_CLASSES,
  ].flatten.freeze
```
it  will add `reset password` and `restore password` documentation

### HOWTO (steps)

1. restore password
2. reset password validation (if needed)
3. reset password!

### Have questions/want to know how to configure somethig?

We have prepared cool [Wiki](https://github.com/MLSDev/api_session_recovering/wiki) page for You!

## About MLSDev

![MLSdev][logo]

ApiSessionRecovering is maintained by MLSDev, Inc. We specialize in providing all-in-one solution in mobile and web development. Our team follows Lean principles and works according to agile methodologies to deliver the best results reducing the budget for development and its timeline.

Find out more [here][mlsdev] and don't hesitate to [contact us][contact]!

[mlsdev]:  https://mlsdev.com
[contact]: https://mlsdev.com/contact_us
[logo]:    https://raw.githubusercontent.com/MLSDev/development-standards/master/mlsdev-logo.png "Mlsdev"
