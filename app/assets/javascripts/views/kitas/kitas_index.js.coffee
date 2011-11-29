class Bremen.Views.KitasIndex extends Backbone.View
  tagName: 'div'
  id: 'kitas-index'
  template: JST['kitas/index']

  render: =>
    $(@el).html @template()
    this
