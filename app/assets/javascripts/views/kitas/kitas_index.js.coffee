class Bremen.Views.KitasIndex extends Backbone.View
  tagName: 'div'
  id: 'kitas-index'
  template: JST['kitas/index']

  events:
    'click #filter-submit': 'filter'
    'click #filter-reset': 'reset'
    'click #filter-close': 'close'
    'click #filter-toggle': 'toggle'

  render: =>
    traegerArten = [
      'öffentlicher Träger'
      'kirchlicher Träger'
      'freier Träger der Wohlfahrtspflege'
      'gemeinütziger Verein'
      'privat-gewerblicher Träger'
      'Elternverein'
      'gemeinnütziger Verein'
    ]
    $(@el).html @template(traegerArten: traegerArten)
    this

  filter: (e) =>
    e.preventDefault()
    window.kitasApp.loadKitas()
    @.$('form#kitas-filter').hide()

  close: (e) =>
    e.preventDefault()
    @.$('form#kitas-filter').hide()

  toggle: (e) =>
    e.preventDefault()
    @.$('form#kitas-filter').toggle()

  reset: (e) =>
    e.preventDefault()
    @.$('form#kitas-filter input[name="traeger_art[]"]').attr('checked', 'checked')
    @.$('form#kitas-filter input[name="alter[]"]').removeAttr('checked')
