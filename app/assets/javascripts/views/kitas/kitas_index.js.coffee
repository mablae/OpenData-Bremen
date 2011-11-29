class Bremen.Views.KitasIndex extends Backbone.View
  tagName: 'div'
  id: 'kitas-index'
  template: JST['kitas/index']

  events:
    'change form#kitas-filter :input': 'filter'

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

  filter: =>
    data = @.$('form#kitas-filter').serializeObject()
    data.per = 1000
    @collection.fetch { data: data }