# Ruboty::Aun

ruboty plugin for binary handler.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruboty-aun'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruboty-aun

## Usage

Put your binary executable handler program to under the `aun/` directory.

Example:

    #!/usr/bin/env php
    <?php
    $body = trim(fgets(STDIN));
    if ($body == 'あ') {
      fwrite(STDOUT, 'うん');
    }

## Contributing

1. Fork it ( https://github.com/blockgiven/ruboty-aun/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
