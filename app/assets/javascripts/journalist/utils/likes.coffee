$ ->
  $('a.likethis[data-remote]').on 'ajax:complete', (event, data, status, xhr)->
    $(this).parent().replaceWith(data.responseText)
