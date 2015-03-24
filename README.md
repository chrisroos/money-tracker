## Money Tracker [![Build Status](https://secure.travis-ci.org/chrisroos/money-tracker.png?branch=master)](http://travis-ci.org/chrisroos/money-tracker)

I've played around with various financial software over time and have never been satisfied with what's on offer.  I'm going to use this project to explore what I believe to be missing and see whether I can build something that I want to use.

See the wiki for a list of [alternative packages](https://github.com/chrisroos/money-tracker/wiki/Alternatives).

## Development

* Tracked in [GitHub Issues](https://github.com/chrisroos/money-tracker/issues)
* Tracked in [Trello](https://trello.com/b/N0kPdGAW/money-tracker)
* Previously tracked in [Pivotal Tracker](https://www.pivotaltracker.com/n/projects/290359)

## Demo

I've deployed a demo copy of the app to [money-tracker-demo.heroku.com](https://money-tracker-demo.heroku.com).  It's configured with the default HTTP basic auth credentials which are 'username' and 'password'.

Do what you want with it, but don't do anything daft like upload sensitive data.  I'll probably delete the data periodically but this won't help if you've just shared your transactions with the world.

## Running the app locally

You'll need postgresql installed if you want to use the example database configuration. This is what Heroku uses.

    $ brew install postgresql

Copy the example database configuration and create all the databases.

    $ cp config/database{.example,}.yml
    $ rake db:create:all
    $ rake db:migrate

### Running the tests

You'll need the [chromedriver executable](http://code.google.com/p/chromium/downloads/list) in your `PATH` to run the cucumber tests.

    $ rake

## Installation on [Heroku](http://www.heroku.com/)

### Clone the app

    $ git clone https://github.com/chrisroos/money-tracker.git ~/money-tracker
    $ cd ~/money-tracker

### Push to Heroku

This assumes that you know what Heroku is and have an account.

    $ heroku apps:create your-app-name --addons sendgrid:starter --stack cedar
    $ git push heroku master
    $ heroku run rake db:migrate

### Change the default username and password

The app is protected by HTTP Basic Authentication.  The default username and password is 'username' and 'password'.  Change them by defining these Heroku variables.

    $ heroku config:add MONEY_TRACKER_USERNAME=my-username
    $ heroku config:add MONEY_TRACKER_PASSWORD=my-password

### Configuring SendGrid so that we get Exception emails

Sometimes the application breaks.  If you want to be emailed when it does you'll want to configure the email address that receives the exception notifications.

    $ heroku config:add MONEY_TRACKER_EXCEPTION_EMAIL_RECIPIENT=your-email-address

## Importing data from Heroku

*NOTE* If you've got a single instance of the app deployed to heroku then you won't need to specify the --app switch

    # Download the data
    $ heroku pgbackups:capture --app money-tracker
    $ curl --silent --output ./tmp/`date "+%Y-%m-%d"`-money-tracker.pgdump `heroku pgbackups:url --app money-tracker`

    # Import the data
    $ pg_restore --verbose --clean --no-acl --no-owner -h localhost -d money_tracker_development ./tmp/`date "+%Y-%m-%d"`-money-tracker.pgdump

## Export data to CSV

    $ rails r script/create-csv.rb "Name of account"
