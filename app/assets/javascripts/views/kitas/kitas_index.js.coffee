class Bremen.Views.KitasIndex extends Backbone.View
  tagName: 'div'
  id: 'kitas-index'
  template: JST['kitas/index']

  events:
    'click #filter-submit': 'filter'
    'click #filter-reset': 'reset'
    'click #filter-close': 'close'

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
    data = @.$('form#kitas-filter').serializeObject()
    data.per = 1000
    @collection.fetch { data: data }
    @.$('form#kitas-filter').hide()

  close: (e) =>
    e.preventDefault()
    @.$('form#kitas-filter').hide()

  reset: (e) =>
    e.preventDefault()
    @.$('form#kitas-filter input[name="traeger_art[]"]').attr('checked', 'checked')
    @.$('form#kitas-filter input[name="alter[]"]').removeAttr('checked')