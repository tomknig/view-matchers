# view-matchers
RSpec-compatible testing matchers for common view contents.
Define ascii-tables and match thei existence with `have_table`.

## Installation

Include the gem in your Gemfile:

```ruby
group :test do
  gem 'view-matchers'
end
```

## Usage

view-matchers exposes some useful matchers for view specs. They are individually documented below.

#### match_table

You can match a table in a rendered view within a describe context with `match_table`.

```ruby
# spec/views/table_spec.rb
expect(rendered).to match_table %(
  +----------+----------+----------+
  |   Number |  Product |    Price |
  +----------+----------+----------+
  |        1 | Computer |  42,00 € |
  +----------+----------+----------+
  |        2 |    Phone |  21,00 € |
  +----------+----------+----------+
)
```

## Contribution & Contributors

I'd love to see your ideas for improving this library!
The best way to contribute is by submitting a pull request or a [new Github issue](https://github.com/TomKnig/view-matchers/issues/new). :octocat:

## Author

[Tom König](http://github.com/TomKnig) [@TomKnig](https://twitter.com/TomKnig)

## Versioning

view-matchers follows Semantic Versioning 2.0 as defined at <http://semver.org>.

## License

view-matchers is available under the MIT license. See the LICENSE file for more info.
