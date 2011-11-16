#= require ./settings

window.log = ->
  if @console and Settings.js_logging
    log.history = log.history || [];
    log.history.push arguments
    console.log Array.prototype.slice.call arguments
