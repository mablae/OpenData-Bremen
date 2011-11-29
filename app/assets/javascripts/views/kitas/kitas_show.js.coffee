class Bremen.Views.KitasShow extends Backbone.View
  tagName: 'div'
  id: 'kitas-show'
  className: 'modal hide fade in'
  template: JST['kitas/show']

  events:
    'click .close': 'close'

  initialize: ->
    @model.bind 'change', @render

  render: =>
    $(@el).html @template(@model.toJSON())
    $(@el).modal backdrop: true, keyboard: true, show: true
    this

  close: =>
    $(@el).bind 'hidden', =>
      @trigger('closed')
      @remove()
    $(@el).modal('hide')
