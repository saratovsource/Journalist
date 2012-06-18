$ ->
  $('a.likethis[data-remote]').on 'ajax:complete', (event, data, status, xhr)->
    parent_itm = $(this).parent()
    response_itm = $(data.responseText)
    console.debug(response_itm)
    link = response_itm.find('a.likethis')
    parent_itm.replaceWith(response_itm)
    link.delay(800).queue (next)->
      $(this).addClass($(this).data('change-class'))
      next()

  $('.likethis[data-change-class]').each ->
    $(this).addClass($(this).data('change-class'))
