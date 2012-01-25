$ ->
	@editable_elements = $('[data-editable]')
	@editable_elements.each ->
		$(this).bind "click", ->
			parent = $(this).parent()
			return false if parent == undefined
			source_object = $(parent).find('[data-editable-source="true"]')
			target_object = $(parent).find('[data-editable-target="true"]')
			if source_object && target_object
				$(source_object).hide()
				$(this).hide()
				$(target_object).show()
			return false