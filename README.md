Scrivener Errors
================

Basic error messages for [Scrivener](https://github.com/soveran/scrivener)
filters.

Description
-----------

Scrivener errors are returned as a hash with a format like:

```ruby
{:email => [:not_email], :password => [:not_present]}
```

This can be represented instead as a string like:

```
Email is not an email, password can't be blank
```

ScrivenerErrors will present these error hashes as a string
or list of error messages for use in failure notices or
form errors.

This also comes with a small plugin for [Cuba](http://cuba.is/)
to get the error message easily, `ScrivenerErrors::Helpers`.

Installation
------------

    $ gem install scrivener_errors

Usage
-----

```ruby
# Setup the plugin for Cuba
require "scrivener_errors"
Cuba.plugin ScrivenerErrors::Helpers

# Inside a Cuba action
filter = Signup.new(req.params)
if !filter.valid?
  session[:error] = filter_error(filter)
  res.redirect "/some_form"
end
```

You can also get a string of comma joined errors for a specific attribute.
It does not include the attribute name in this case.

```ruby
scrivener_errors[:email] # => "is too short, is not an email"
```

Notes
-----

Currently there's no I18n in use.  The error messages are
from a small English mapped hash at the moment.

An error type that is not found will be represented like
"Password is invalid" by default.
