#= require underscore

window.Map = class
  constructor: (@containerId, options) ->
    defaults =
      zoom: 12
      maxZoomLevel: 21
      mapTypeId: google.maps.MapTypeId.ROADMAP
      disableDoubleClickZoom: true
      scrollwheel: false
      navigationControlOptions:
        style: google.maps.NavigationControlStyle.ZOOM_PAN
      mapTypeControlOptions:
        mapTypeIds: [google.maps.MapTypeId.HYBRID, google.maps.MapTypeId.SATELLITE, google.maps.MapTypeId.ROADMAP]
    @markers = [];
    @markerBounds = new google.maps.LatLngBounds();
    @options = $.extend(defaults, options);
    @googleMap = new google.maps.Map(document.getElementById(@containerId), @options);
    @container = $("##{@containerId}")

  # Markers
  clearMarkers: ->
    _.each @markers, (marker) =>
      marker.unbindAll()
      marker.setMap null
    @markers = []
    @markerBounds = new google.maps.LatLngBounds()

  markerIcon: (icon_url) ->
    new google.maps.MarkerImage icon_url,
      new google.maps.Size(16,16),
      new google.maps.Point(0,0),
      new google.maps.Point(5,5)

  markerForObject: (data) ->
    opts =
      position: @latLng data.latitude, data.longitude
      title: data.title
      map: @googleMap
      # icon: @markerIcon data.map_icon_url
    new google.maps.Marker opts

  addObject: (obj) ->
    marker = @markerForObject obj
    @markerBounds.extend marker.getPosition()
    @markers.push marker
    marker

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
