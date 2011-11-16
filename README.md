OpenData Bremen
===============

Eine kleine Ruby on Rails/Backbone.js Applikation um mit den [offenen Daten von Bremen](http://daten.bremen.de/) zu spielen.

Setup
-----

  * `bundle`
  * `cp config/database.example.yml config/database.yml`
  * Datenbank-Konbfiguration anpassen
  * `bundle exec rake db:setup`
  * `rails server`
  * Rock on!

Testing
-------

Die Tests lassen sich mit folgenden Kommandos starten:

  * `bundle exec guard`
  * `bundle exec cucumber`

Hinweise
--------

Um mit Kodierungsproblemen der Dateien auf Bremen.de umzugehen kann man die CSV-Daten im Browser öffnen und sie von dort aus der Seite kopieren und in TextMate (o.ä.) einfügen und sie dann UFT-8 kodiert abspeichern.
