# symbol-fstring

`symbol-fstring` is a Ruby extension that provide access to symbols internal string representations.

## Why?

In Ruby many APIs tend to accept symbols, but regularly convert them to string internally. The typical example is
`ActiveSupport::HashWithIndifferentAccess`, but there are plenty more.

The problem with this is that `Symbol#to_s` creates a new string every time it is invoked, and since it often happens
in hotspots, it causes a lot of work for the garbage collector, and cause many identical strings to be kept in memory.

There was [an attempt to make `Symbol#to_s` return it's internal fstring for Ruby 2.7](https://bugs.ruby-lang.org/issues/16150),
but unfortunately it got reverted, and probably won't happen before a while.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'symbol-fstring'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install symbol-fstring

## Usage

`FString` can be used in two ways. 

### `FString.patch_symbol!`

If your application and your dependencies are compatible with it, you can change `Symbol#to_s` behavior globally with:

```ruby
FString.patch_symbol!
```

Or you can also add it this way in your Gemfile:

```ruby
gem 'fstring', require: 'fstring/all'
```

### `FString.to_s`

If you don't want to patch the core `Symbol` class, you can alternatively substitute `some_symbol.to_s` for
`FString.to_s(some_symbol)` in your own code.

### Benchmark

From `benchmark/symbol-to_s`

```
 Symbol#to_s (orig)     12.786M (± 1.5%) i/s -     64.032M in   5.009020s
FString.symbol_to_s     20.371M (± 1.7%) i/s -    101.981M in   5.007706s
       FString.to_s     19.086M (± 1.5%) i/s -     95.410M in   5.000016s
Symbol#to_s (patch)     21.669M (± 1.9%) i/s -    108.591M in   5.013331s
```

But there's also a reduced pressure on the garbage collector.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Shopify/symbol-fstring.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
