# "Active Rails" Sample Application

This is my walk-through of the book [Active Rails](https://leanpub.com/rails).

The book version is "2020-10-06 (b5bf66cec)".

## Development

```
$ rbenv install 2.7.2
$ brew install postgresql
$ bundle
$ bin/rspec
```

## Deployment

```
$ heroku apps:create ticketee-`ruby -e 'print rand(10000...100000)'`
$ git push heroku master
$ heroku run bin/rails db:migrate db:seed
```
