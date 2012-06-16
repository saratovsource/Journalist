$ ->
  bind_preview()

@bind_preview = () ->
  overlays = $('.bgoverlay[data-elements]')
  overlays.on "click", ->
    $($(this).data("elements")).removeClass("active")
  $('[data-preview]').on "click", (e)->
    e.stopPropagation()
    $(this).addClass "active"
