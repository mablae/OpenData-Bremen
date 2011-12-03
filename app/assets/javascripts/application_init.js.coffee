jQuery ($) ->
  # Bootstrap
  $('a[rel=twipsy]').twipsy live: true
  $('a[rel=popover]').popover offset: 10

  # Kitas
  if $('#kitas-app').length
    window.kitasApp = new Bremen.Routers.Kitas()
    Backbone.history.start(pushState: true)