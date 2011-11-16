class Bremen.Routers.Kitas extends Backbone.Router
  routes:
    "": "index"

  index: ->
    # Map
    @map = new Map "kita-map", zoom: 12
    @map.centerAt(Settings.default_latitude, Settings.default_longitude)
    # Kitas
    @kitas = new Bremen.Collections.Kitas()
    @kitas.fetch { data: { per: 1000 } }
    @kitas.bind 'reset', =>
      @map.clearMarkers()
      @map.addObjects @kitas.toJSON()
