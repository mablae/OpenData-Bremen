#= require underscore
#= require markerclusterer

# Convenience extension to the Google Maps Marker
google.maps.Marker.prototype.on = (event, handler) ->
  google.maps.event.addListener this, event, handler

window.Map = class
  constructor: (@containerId, options) ->
    defaults =
      zoom: 12
      maxZoomLevel: 21
      mapTypeId: google.maps.MapTypeId.ROADMAP
      scrollwheel: false
      navigationControlOptions:
        style: google.maps.NavigationControlStyle.ANDROID
      mapTypeControlOptions:
        mapTypeIds: [google.maps.MapTypeId.HYBRID, google.maps.MapTypeId.SATELLITE, google.maps.MapTypeId.ROADMAP]
    @markers = [];
    @markerBounds = new google.maps.LatLngBounds()
    @options = $.extend(defaults, options)
    @mapLoaded = false
    @googleMap = new google.maps.Map(document.getElementById(@containerId), @options)
    @on 'idle', =>
      unless @mapLoaded
        # Map-Controls mit IDs versehen
        @labelControlsWithId()
        @mapLoaded = true
    @clusterer = new MarkerClusterer(@googleMap, @markers, maxZoom: 14)
    @container = $("##{@containerId}")
    @labelControlsWithId()

  # Markers
  clearMarkers: ->
    _.each @markers, (marker) =>
      marker.unbindAll()
    @markers = []
    @markerBounds = new google.maps.LatLngBounds()
    @clusterer.clearMarkers()

  markerForObject: (data, opts) ->
    defaults = position: @latLng data.latitude, data.longitude
    new google.maps.Marker $.extend(defaults, opts)

  addMarker: (marker) ->
    @markerBounds.extend marker.getPosition()
    @markers.push marker
    @clusterer.addMarker marker
    marker

  addObject: (obj) ->
    @addMarker(@markerForObject obj)

  addObjects: (objects) ->
    _.each objects, (obj) =>
      @addObject obj

  # Events
  on: (event, handler) ->
    google.maps.event.addListener @googleMap, event, handler

  # Convenience Accessors
  latLng: (lat, lng) ->
    new google.maps.LatLng(lat, lng)

  zoomLevel: ->
    @googleMap.getZoom()

  setZoomLevel: (level) ->
    @googleMap.setZoom if level > @options.maxZoomLevel then @options.maxZoomLevel else level

  zoomIn: ->
    @setZoomLevel @zoomLevel()+1

  zoomOut: ->
    @setZoomLevel @zoomLevel()-1

  zoomTo: (lat, lng) ->
    @setZoomLevel @options.zoom
    @googleMap.panTo @latLng(lat, lng)

  centerAt: (lat, lng) ->
    @googleMap.setCenter @latLng(lat, lng)

  fitBounds: ->
    @googleMap.fitBounds @markerBounds
    @setZoomLevel @options.maxZoomLevel if @zoomLevel() > @options.maxZoomLevel

  bounds: ->
    @googleMap.getBounds()

  center: ->
    @googleMap.getCenter()

  northEast: ->
    @bounds().getNorthEast()

  southWest: ->
    @bounds().getSouthWest()

  topRightLat: ->
    @northEast().lat()

  topRightLng: ->
    @northEast().lng()

  bottomLeftLat: ->
    @southWest().lat()

  bottomLeftLng: ->
    @southWest().lng()

  topLeft: ->
    @latLng @topRightLat(), @bottomLeftLng()

  topRight: ->
    @latLng  @topRightLat(), @topRightLng()

  bottomLeft: ->
    @latLng  @bottomLeftLat(), @bottomLeftLng()

  bottomRight: ->
    @latLng  @bottomLeftLat(), @topRightLng()

  # Labels the Map Controls with IDs so they can be referenced with CSS, see:
  # http://stackoverflow.com/questions/4924456/custom-position-non-custom-control-google-maps-v3-api
  labelControlsWithId: ->
    controlList =
      'map_type_control': 'margin-top: 5px; margin-right: 5px; margin-bottom: 5px; margin-left: 5px; z-index: 0; position: absolute; cursor: pointer; right: 0px; top: 0px;'
      'pan_control': 'cursor: url(https://maps-api-ssl.google.com/intl/en_us/mapfiles/openhand_8_8.cur), default; width: 78px; height: 78px; position: absolute; left: 0px; top: 0px; '
      'zoom_control': 'position: absolute; left: 27px; top: 128px; '
      'zoom_control_android': 'position: absolute; left: 0px; top: 5px;'
      'streetmap_control': 'width: 32px; height: 38px; overflow-x: hidden; overflow-y: hidden; position: absolute; left: 0px; top: 0px; '
      'streetmap_control_android': 'margin-top: 5px; margin-right: 5px; margin-bottom: 5px; margin-left: 5px; -webkit-user-select: none; position: absolute; top: 0px; left: 0px; '
      'hidden_streetmap_control': 'width: 32px; height: 38px; overflow-x: hidden; overflow-y: hidden; position: absolute; left: 0px; top: 0px; visibility: hidden; '
    $.each controlList, (id, attr) =>
      ctrl = @container.find("div[style*='#{attr}']")
      ctrl.attr('id', id) if ctrl.length == 1
    true
