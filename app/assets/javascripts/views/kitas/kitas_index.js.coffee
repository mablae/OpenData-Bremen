class Bremen.Views.KitasIndex extends Backbone.View
  el: 'div#kitas-index'

  events:
    'click #filter-submit': 'filter'
    'click #filter-reset': 'reset'
    'click #filter-close': 'close'
    'click #filter-toggle': 'toggle'
    'click .page': 'showPage'
    'submit #search': 'search'

  filter: (e) =>
    e.preventDefault()
    window.kitasApp.loadKitas()
    @.$('form#kitas-filter').hide()

  close: (e) =>
    e.preventDefault()
    @.$('form#kitas-filter').hide()

  toggle: (e) =>
    e.preventDefault()
    @.$('form#kitas-filter').toggle()

  showPage: (e) ->
    e.preventDefault()
    pageId = $(e.target).data('page-id')
    $("##{pageId}").modal backdrop: true, keyboard: true, show: true

  reset: (e) =>
    e.preventDefault()
    @.$('form#kitas-filter input[name="traeger_art[]"]').attr 'checked', 'checked'
    @.$('form#kitas-filter input[name="alter[]"]').removeAttr 'checked'

  search: (e) =>
    e.preventDefault()
    $adresse = @.$('form#search input#adresse')
    adresse = $adresse.val()
    if adresse.length
      $adresse.attr 'disabled', 'disabled'
      geocoder = new google.maps.Geocoder()
      unless /Bremen/i.test adresse
        adresse = "#{adresse}, Bremen"
        $adresse.val adresse
      geocoder.geocode {'address': adresse}, (results, status) ->
        $adresse.removeAttr('disabled')
        if status is google.maps.GeocoderStatus.OK
          loc = results[0].geometry.location
          window.kitasApp.setPosition loc.lat(), loc.lng()
        else
          alert 'Die gesuchte Adresse konnte nicht gefunden werden.'
