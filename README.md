# Jscon

js repl for rails

## Usage

```bash
    $ jscon
    > a = 1
    1
    > b = function (){ return "B";}
    [Function]
    > $.fn.jquery
    "1.9.1"
    > Backbone.VERSION
    "1.1.0"
    > _.VERSION
    "1.5.0"
```

```bash
    $ jscon --coffee
    > @a = 1
    1
    > @b = -> "B"
    [Function]
    > @b()
    "B"
```

## Installation

Add this line to your application's Gemfile:

    gem 'jscon'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jscon


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
