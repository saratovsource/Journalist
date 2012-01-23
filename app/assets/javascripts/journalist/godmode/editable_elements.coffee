$ ->
	@editable_elements = $('[data-editable]')
	@editable_elements.each ->
		$(this).bind "click", ->
			source_object = $(this).parents().find('[data-editable-source]')
			target_object = $(this).parents().find('[data-editable-target]')
			if source_object && target_object
				$(source_object).hide()
				$(this).hide()
				$(target_object).show()
			return false