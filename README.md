## Money Tracker

I've played around with various financial software over time and have never been satisfied with what's on offer.  I'm going to use this project to explore what I believe to be missing and see whether I can build something that I want to use.

It's got some [stories](https://www.pivotaltracker.com/projects/290359) and a list of [alternative packages](https://github.com/chrisroos/money-tracker/wiki/Alternatives).  What more could you want.

## Demo

I've deployed a demo copy of the app to [money-tracker-demo.heroku.com](https://money-tracker-demo.heroku.com).  It's configured with the default HTTP basic auth credentials which are 'username' and 'password'.

Do what you want with it, but don't do anything daft like upload sensitive data.  I'll probably delete the data periodically but this won't help if you've just shared your transactions with the world.

## Installation on [Heroku](http://www.heroku.com/)

### Clone the app

    $ git clone https://github.com/chrisroos/money-tracker.git ~/money-tracker
    $ cd ~/money-tracker

### Push to Heroku

This assumes that you know what Heroku is, have an account and installed the gem.

    $ heroku apps:create
    $ git push heroku master
    $ heroku rake db:migrate

### Install the SSL addon

The app uses SSL to encrypt the data between the server and your browser.  It redirects all plain HTTP requests over HTTPS so it won't work without this addon.

    $ heroku addons:add ssl:piggyback

### Change the default username and password

The app is protected by HTTP Basic Authentication.  The default username and password is 'username' and 'password'.  Change them by defining these Heroku variables.

    $ heroku config:add MONEY_TRACKER_USERNAME=my-username
    $ heroku config:add MONEY_TRACKER_PASSWORD=my-password

### Configuring SendGrid so that we get Exception emails

Sometimes the application breaks.  If you want to be emailed when it does you'll want to enable the free [SendGrid](http://sendgrid.com/) addon and set your email address.

    $ heroku addons:add sendgrid:free
    $ heroku config:add MONEY_TRACKER_EXCEPTION_EMAIL_RECIPIENT=your-email-address