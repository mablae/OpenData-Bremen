class Bremen.Routers.Kitas extends Backbone.Router
  routes:
    "": "index"

  index: ->
    log Settings
    # Map
    @map = new Map "kita-map",
      zoom: 12,
      center: new google.maps.LatLng(Settings.default_latitude, Settings.default_longitude)
    @map.centerAt(Settings.default_latitude, Settings.default_longitude)
    window.map = @map
    # Kitas
    @kitas = new Bremen.Collections.Kitas()
    @kitas.fetch { data: { per: 1000 } }
    @kitas.bind 'reset', =>
      @map.clearMarkers()
      @map.addObjects @kitas.toJSON()
