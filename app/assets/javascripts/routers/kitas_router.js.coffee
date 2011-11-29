class Bremen.Routers.Kitas extends Backbone.Router
  routes:
    '': 'index'
    ':id': 'show'

  initialize: ->
    @kitas = new Bremen.Collections.Kitas()
    @kitas.bind 'reset', @refreshMap
    @indexView = new Bremen.Views.KitasIndex(collection: @kitas)
    $('#kitas-app').html(@indexView.render().el)
    @map = new Map 'kitas-map', zoom: 12
    @map.centerAt(Settings.default_latitude, Settings.default_longitude)
    # Benutzerposition
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition (position) =>
        if position.coords?
          lat = position.coords.latitude
          lng = position.coords.longitude
          @map.centerAt lat, lng
          @map.setZoomLevel 15
          marker = @map.markerForObject { latitude: lat, longitude: lng },
            title: 'Ihre aktuelle Position'
            icon: MapIcons.icon('position')
          marker.setMap @map.googleMap
    # Kitas laden
    @kitas.fetch { data: { per: 1000 } }

  index: ->
    # log 'index'

  show: (id) ->
    kita = @kitas.get(id)
    if kita
      @showView.close() if @showView
      @showView = new Bremen.Views.KitasShow(model: kita)
      $('#kitas-app').append(@showView.render().el)
    else
      # Funktion auf das reset binden, da die Collection noch nicht geladen
      # ist. Bei der Ausführung muss unbind ausgeführt werden, da sonst bei
      # erneutem fetch wieder die Startkita angezeigt wird. Leider geht es
      # nicht mit einer anonymen Funktion, da wir sie im unbind namentlich
      # referenzieren müssen.
      showOnStart = =>
        @kitas.unbind 'reset', showOnStart
        @show(id)
      @kitas.bind 'reset', showOnStart

  refreshMap: =>
    @map.clearMarkers()
    @kitas.each (kita) =>
      marker = @map.markerForObject { latitude: kita.get('latitude'), longitude: kita.get('longitude')},
        title: kita.get('name')
        icon: MapIcons.icon('kita')
      marker.on 'click', =>
        @navigate("#{kita.id}", true)
      kita.set(marker: marker)
      @map.addMarker marker
