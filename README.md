# Rails Engine

This is a sales API made in a Ruby on Rails backend!

Sales engine in Rails... Rails Engine...

* Endpoints
- `get 'api/v1/merchants'` - to get all merchants loaded in the database
- `get 'api/v1/merchants/{merchant id}'` - to get a specific merchant's details
- `get 'api/v1/merchants/{merchant id}/items'` - to get the items in the database that belong to a merchant

* Ruby version
  * 2.5.3

* Rails version
  * 5.2.5

* Configuration

`bundle install`

* Database creation

Simply run `rails db:setup` in your terminal/command line!

* How to run the test suite

`bundle exec rspec`
