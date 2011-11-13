bremen
====================

Setup
-----

  * `bundle`
  * `cp config/database.example.yml config/database.yml`
  * Make the necessary changes to the database configuration
  * `bundle exec rake db:setup`
  * `rails server`
  * Rock on!

Testing
-------

Start them with the following commands:

  * `bundle exec guard`
  * `bundle exec cucumber`

Deployment
----------

    bundle exec rake vlad:deploy
