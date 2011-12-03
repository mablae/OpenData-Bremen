class Bremen.Views.KitasIndex extends Backbone.View
  el: 'div#kitas-index'

  events:
    'click #filter-submit': 'filter'
    'click #filter-reset': 'reset'
    'click #filter-close': 'close'
    'click #filter-toggle': 'toggle'
    'click .page': 'showPage'

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

  showPage: (e) ->
    e.preventDefault()
    pageId = $(e.target).data('page-id')
    $("##{pageId}").modal(backdrop: true, keyboard: true, show: true)

  reset: (e) =>
    e.preventDefault()
    @.$('form#kitas-filter input[name="traeger_art[]"]').attr('checked', 'checked')
    @.$('form#kitas-filter input[name="alter[]"]').removeAttr('checked')
