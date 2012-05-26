$ ->
  $('a[data-reply]').bind 'ajax:success', (data, xhr, status)->
    $(this).parents('.post').after(xhr)
    $(this).fadeOut()
