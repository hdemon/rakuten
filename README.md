# Rakuten

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'rakuten'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rakuten

## Usage

```
require "rakuten"

books = Rakuten::BooksTotal.new(appId: xxx)
p books.fetch title: "這い寄れ！ニャル子さん"
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/rakuten/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
