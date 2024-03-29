class Bremen.Routers.Kitas extends Backbone.Router
  routes:
    '': 'index'
    ':id/:slug': 'show'

  initialize: ->
    @kitas = new Bremen.Collections.Kitas()
    @kitas.bind 'reset', @refreshMap
    @indexView = new Bremen.Views.KitasIndex collection: @kitas
    @map = new Map 'kitas-map', zoom: 12
    @map.centerAt Settings.default_latitude, Settings.default_longitude
    # Benutzerposition
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition (position) =>
        (@setPosition position.coords.latitude, position.coords.longitude) if position.coords?
    # Kitas laden
    @loadKitas()

  index: ->
    @updateTitle null

  show: (id, slug) ->
    kita = @kitas.get(id)
    if kita
      @showView.close() if @showView
      @showView = new Bremen.Views.KitasShow model: kita
      $('#kitas-app').append @showView.render().el
      @updateTitle kita.get('name')
    else
      # Funktion auf das reset binden, da die Collection noch nicht geladen
      # ist. Bei der Ausführung muss unbind ausgeführt werden, da sonst bei
      # erneutem fetch wieder die Startkita angezeigt wird. Leider geht es
      # nicht mit einer anonymen Funktion, da wir sie im unbind namentlich
      # referenzieren müssen.
      showOnStart = =>
        @kitas.unbind 'reset', showOnStart
        @show id, slug
      @kitas.bind 'reset', showOnStart

  loadKitas: ->
    data = $('form#kitas-filter').serializeObject()
    data.per = 1000
    $('#loading img').show()
    @kitas.fetch { data: data, complete: (-> $('#loading img').hide()) }

  refreshMap: =>
    @map.clearMarkers()
    @kitas.each (kita) =>
      marker = @map.markerForObject { latitude: kita.get('latitude'), longitude: kita.get('longitude')},
        title: kita.get('name')
        icon: image_path 'kita.png'
      marker.on 'click', =>
        @navigate "#{kita.id}/#{kita.get('slug')}", true
      @map.addMarker marker

  setPosition: (lat, lng) =>
    # Überprüfen ob die Position innerhalb Bremens liegt
    box = Settings.bounding_box
    latIn = lat >= box.sw_lat and lat <= box.ne_lat
    lngIn = lng >= box.sw_lng and lng <= box.ne_lng
    if latIn and lngIn
      @map.centerAt lat, lng
      @map.setZoomLevel 15
      @positionMarker.setMap null if @positionMarker
      @positionMarker = @map.markerForObject { latitude: lat, longitude: lng },
        title: 'Ihre aktuelle Position'
        icon: image_path 'position.png'
      @positionMarker.setMap @map.googleMap
    else
      alert 'Die Adresse liegt nicht innerhalb Bremens.'

  updateTitle: (title) =>
    app_title = $('title').data('app-title')
    document.title = if title? then "#{title} - #{app_title}" else app_title