@growl = (title , message) ->
	$.gritter.add(
		title: 	title,
		text:		message
	)