$ ->
  load_next_page()

@load_next_page = () ->
  $('[data-infinity]').on 'ajax:success', (event, data, status, xhr)->
    replace_wrapper = $(this).data('infinity')
    $(this).closest(replace_wrapper).replaceWith(xhr.responseText)
    bind_preview()
    load_next_page()
