# 2015

##	March 2015

### March 24

* Moved remaining stories from PT to Trello - https://trello.com/c/D5eMyEuH/25-move-stories-from-pt-to-trello

### March 20

* Upgraded from Bootstrap 2 to 3
* Switched from twitter-bootstrap-rails to bootstrap-sass gem

### March 19

* Rename some fields in transaction table to make it clear they're populated from OFX file
* Re-ordered Transaction class to make it a little more "standard"
* Played with auto-deploying from GitHub pushes but reverted as I was uncomfortable with the amount of access it required.
* Upgraded to cedar-14 stack.
* Added timestamp fields to transactions table.

## February 2015

### February 28

* Reverted my local changes that were attempting to upgrade the project to Rails 4.2.0
* Moved functional tests to test/controllers
* Moved unit tests to test/models
* Upgraded to Rails 4.0.13 with no problem
* Upgraded to Rails 4.1.9 with no problem
* Ran `rails _4.1.9_ new money-tracker` to refresh all the default Rails components and carefully accepted/rejected various changes
* Configured the project to use Ruby 2.2.0 instead of 4.1.9
* Merged James's two pull requests
* Upgraded to Rails 4.2.0

### February 27

* Tried updating all the gems (`bundle update`) but tests started failing
* One of the test failures is related to this Mocha issue - https://github.com/freerange/mocha/issues/199 - which suggests that upgrading the version of Ruby will help.
* I'm now installing Ruby 2.0.0-p643
* I've blown away the bundled gems and am running `bundle install` again to get versions compatible with the new version of ruby
* Manually upgrading each gem using `bundle update <gem-name>`
* Removed unused Gems
* I'm fixing/ignoring Rubocop warnings in preparation for making Rubocop part of the build
* I'm now running Rubocop as part of the default Rake task
* I tried to upgrade to Rails 4.2.0 but had some problems with failing tests

# 2014

## December 2014

### December 7

* Added support for my Barclaycard recent transactions, which involved forking and amending the OFX gem I'm using - https://github.com/chrisroos/money-tracker/commit/afd8e63db36e0a5137e19010e1e22ec4aae4a984

# 2013

## November 2013

### Sunday November 17

* Added auto-complete to the location field - autocomplete suggestions are restricted based on the description of the transaction.

### Thursday November 14

* Upgraded to Rails 4.0.1
