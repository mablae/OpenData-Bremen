jQuery ($) ->
  # Bootstrap
  $('a[rel=twipsy]').twipsy live: true
  $('a[rel=popover]').popover offset: 10

  # Common
  $('.filter-toggle').click (e) ->
    e.preventDefault()
    $('.filter-form').toggle()

  # Kitas
  if $('#kitas-app').length
    window.kitasApp = new Bremen.Routers.Kitas()
    Backbone.history.start(root: '/kitas')