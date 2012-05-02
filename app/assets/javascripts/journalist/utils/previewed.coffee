$ ->
  $('.bgoverlay[data-elements]').bind "click", ->
    $($(this).data("elements")).removeClass("active")
  $('[data-preview]').bind "click", (e)->
    e.stopPropagation()
    $(this).addClass "active"
