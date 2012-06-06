$ ->
  $('a.likethis[data-remote]').on 'ajax:complete', (event, data, status, xhr)->
    parent_itm = $(this).parent()
    added_class = $(this).data('add-class')
    response_itm = $(data.responseText)
    console.debug(response_itm)
    link = response_itm.find('a.likethis')
    parent_itm.replaceWith(response_itm)
    link.delay(800).queue (next)->
      $(this).addClass(added_class)
      next()

  $('a.likethis[data-remote]').each ->
    if $(this).data('likes') > 0
      $(this).addClass($(this).data('add-class'))
