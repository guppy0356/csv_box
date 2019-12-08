# CSVBox

CSVBOx provides DLS to define CSV header layout.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'csv_box'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install csv_box

## Usage

```ruby
Book = Struct.new(:id, :title, :price)
books = [Book.new(1, 'How to cook delicious meals', 1500), Book.new(2, '10 tips to lose weight', 250)]

CSVBox.add 'book' do
  field 'id'
  field 'title'
  field 'price'
end

CSVBox.layouts 'book' do
  layout 'shuffled layout' do |box|
    box.price
    box.id
    box.title
  end
end

box = CSVBox.take 'book', 'shuffled layout'

books.each do |book|
  box << book
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/guppy0356/csv_box. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CSVBox project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/guppy0356/csv_box/blob/master/CODE_OF_CONDUCT.md).
