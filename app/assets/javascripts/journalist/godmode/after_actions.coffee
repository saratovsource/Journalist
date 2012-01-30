$ ->
	$('[data-after-action]').each ->
		event_name = $(this).attr('data-after-action')
		target_element_name = $(this).attr('data-target')
		target_form = $(this).parents('form')
		$(this).bind 'click', ->
			target_element = $('[name="'+target_element_name+'"]')
			$(target_element).val(event_name)
			$(target_form).submit()
			return false