$ ->
	$('fieldset.toogle').each ->
		$(this).find('legend').bind "click", (e) ->
			if $(this).parent().hasClass('off')
				$(this).parent().removeClass('off').addClass('on')
			else
				$(this).parent().removeClass('on').addClass('off')