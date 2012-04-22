$ ->
  $('.bgoverlay[data-elements]').bind "click", ->
    $($(this).data("elements")).removeClass("active")
  $('[data-preview]').bind "click", ->
    $(this).addClass "active"
