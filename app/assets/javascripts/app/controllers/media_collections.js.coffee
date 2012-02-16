$ = jQuery.sub()
MediaCollection = App.MediaCollection

$.fn.item = ->
  elementID   = $(@).data('id')
  elementID or= $(@).parents('[data-id]').data('id')
  MediaCollection.find(elementID)

class New extends Spine.Controller
  events:
    'click [data-type=back]': 'back'
    'submit form': 'submit'
    
  constructor: ->
    super
    @active @render
    
  render: ->
    @html @view('media_collections/new')

  back: ->
    @navigate '/media_collections'

  submit: (e) ->
    e.preventDefault()
    media_collection = MediaCollection.fromForm(e.target).save()
    @navigate '/media_collections', media_collection.id if media_collection

class Edit extends Spine.Controller
  events:
    'click [data-type=back]': 'back'
    'submit form': 'submit'
  
  constructor: ->
    super
    @active (params) ->
      @change(params.id)
      
  change: (id) ->
    @item = MediaCollection.find(id)
    @render()
    
  render: ->
    @html @view('media_collections/edit')(@item)

  back: ->
    @navigate '/media_collections'

  submit: (e) ->
    e.preventDefault()
    @item.fromForm(e.target).save()
    @navigate '/media_collections'

class Show extends Spine.Controller
  events:
    'click [bata-type=edit]': 'edit'
    'click [data-type=back]': 'back'

  constructor: ->
    super
    @active (params) ->
      @change(params.id)

  change: (id) ->
    @item = MediaCollection.find(id)
    @render()

  render: ->
    @html @view('media_collections/show')(@item)

  edit: ->
    @navigate '/media_collections', @item.id, 'edit'

  back: ->
    @navigate '/media_collections'

class Index extends Spine.Controller
  events:
    'click [data-type=edit]':    'edit'
    'click [data-type=destroy]': 'destroy'
    'click [data-type=show]':    'show'
    'click [data-type=new]':     'new'

  constructor: ->
    super
    MediaCollection.bind 'refresh change', @render
    MediaCollection.fetch()
    
  render: =>
    media_collections = MediaCollection.all()
    @html @view('media_collections/index')(media_collections: media_collections)
    
  edit: (e) ->
    item = $(e.target).item()
    @navigate '/media_collections', item.id, 'edit'
    
  destroy: (e) ->
    item = $(e.target).item()
    item.destroy() if confirm('Sure?')
    
  show: (e) ->
    item = $(e.target).item()
    @navigate '/media_collections', item.id
    
  new: ->
    @navigate '/media_collections/new'
    
class App.MediaCollections extends Spine.Stack
  controllers:
    index: Index
    edit:  Edit
    show:  Show
    new:   New
    
  routes:
    '/media_collections/new':      'new'
    '/media_collections/:id/edit': 'edit'
    '/media_collections/:id':      'show'
    '/media_collections':          'index'
    
  default: 'index'
  className: 'stack media_collections'