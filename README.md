# Rails Engine
## Author
Hope McGee (Gochnour) | [LinkedIn](https://www.linkedin.com/in/hope-mcgee/) | [GitHub](github.com/hopesgit)

## Description
This is a sales API made in a Ruby on Rails backend! Sales engine in Rails... Rails Engine...

## Endpoints

### Merchant Endpoints
- `get 'api/v1/merchants'` - to get all merchants loaded in the database
- `get 'api/v1/merchants/{merchant id}'` - to get a specific merchant's details
- `get 'api/v1/merchants/{merchant id}/items'` - to get the items in the database that belong to a merchant

### Item Endpoints
- `get 'api/v1/items'` - to get all items in the database.
- `get 'api/v1/items/{item id}'` - to get information for a specific item.
- `post 'api/v1/items'` - This requires a JSON body with item attributes. Use to create a new item.
- `patch 'api/v1/items/{item id}'` - This requires a JSON body with the attributes you wish to change. Use to update an item.
- `delete 'api/v1/items/{item id}'` - to delete an item in the database.
- `get 'api/v1/items/{item id}/merchant'` - to fetch merchant information for the given item id

### Notes
the all-merchant and all-item endpoints support these modifiers, sent as params:
- `per_page`: Use this to change how many records are returned in one page. The default is 20.
- `page`: Use this to get the next set of records or to display a particular record set.

## Setup, Versioning, and Database
Ruby version
* 2.5.3

Rails version
* 5.2.5

Configuration

* Be sure to run `bundle install` in your terminal to get started!

Database creation

* Simply run `rails db:setup` in your terminal/command line!

How to run the test suite

* Run `bundle exec rspec` in your terminal to get a report from the test suite.

How to test this app for yourself

* Once the other setup steps have been taken, run `rails s` in your terminal to create a local server. With that running, you can make your own requests using your browser or a more sophisticated query interface, such as Postman.
