$ ->
	$('textarea[data-content-editor]').each ->
		$(this).markItUp(makitup_sets[$(this).attr("data-content-editor")]);