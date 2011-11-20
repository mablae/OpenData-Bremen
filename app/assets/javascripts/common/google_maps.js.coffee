# Convenience extension to the Google Maps Marker
google.maps.Marker.prototype.on = (event, handler) ->
  google.maps.event.addListener this, event, handler