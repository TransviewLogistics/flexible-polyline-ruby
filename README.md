# About
This is a Ruby implementation of the flexible polyline format in a Gem. ONLY THE DECODING IS INCLUDED CURRENTLY (please contribute - we had no need for the encoding!!!)

The flexible polyline encoding is a lossy compressed representation of a list of coordinate pairs or coordinate triples. This data format is used by HERE Technologies for their mapping/routing but could be used elsewhere. You can read more about it in [their repo](https://github.com/heremaps/flexible-polyline), which also contains the js version that was reverse engineered to make the decoder in this gem.

# Installation
- If using bundler (recommended), add `gem 'flexible_polyline'` to your Gemfile to install it via `$ bundle install`.
- Otherwise, run `$ gem install flexible_polyline`.

# Usage
#### Decoding:
```
FlexiblePolyline::Decoder.new.decode(my_flexible_polyline)
```

# TODO
- Implement the encoder!

# How To Contribute
- Fork the repository into your own GitHub
- Clone the repository to your local machine
- Create a new branch for your changes
- Make some changes and commit them with useful messages
- Push the changes to your repository
- Create a Pull Request from your repository back to the original one

#### Local setup/tests/info:
- Assuming you already have Ruby installed, run `$ bundle install`.
- Verify you can run the tests via `ruby -Ilib:test test/**/*.rb` and they pass.
- Contributions must include test coverage
