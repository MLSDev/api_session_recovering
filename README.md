# ApiSessionRecovering

ApiSessionRecovering.

Only Rails ~> 5 support.

## Installation

Add these to your Gemfile

``` ruby
gem 'api_session_recovering'
```

...and run `bundle install` to install the gem.

Next, run:

``` bash
# add an initializer to config/initializers with all of the configuration options
rake g api_session_recovering:install

# This will add the necessary migrations to your app's db/migrate directory
rake api_session_recovering:migrations

# This will run any pending migrations
rake db:migrate
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
  restore_password POST /session/restore_password(.:format)
  reset_password   POST /session/reset_password(.:format)
```
