@jq_sortable_fix = (e, ui) ->
	ui.children().each ->
		$(this).width($(this).width());
	ui
$ ->
	$('[data-sortable]').each ->
		$(this).find('tbody').sortable(
			helper: jq_sortable_fix,
			'axis': 'y',
			"handle": 'td.dragHandle',
			'update': (event, ui) ->
				params = $(this).sortable('serialize', { 'key': 'children[]' })
				params += '&_method=put'
				params += '&' + $('meta[name=csrf-param]').attr('content') + '=' + $('meta[name=csrf-token]').attr('content')
				#console.debug(params)
				
				$.post(
					$(this).attr('data-url'), 
					params,
					(data) ->
						growl(data.message.title, data.message.text)
					,
					"json"
				)
		)
		
	$("[data-grid-sortable]").each ->
		$(this).sortable({
			update: (event, ui)->
				params = $(this).sortable('serialize', { 'key': 'children[]' })
				params += '&_method=put'
				params += '&' + $('meta[name=csrf-param]').attr('content') + '=' + $('meta[name=csrf-token]').attr('content')
				
				$.post(
					$(this).attr('data-url'), 
					params,
					(data) ->
						growl(data.message.title, data.message.text)
					,
					"json"
				)
		})
	
	$("table[data-sorted]").each ->
		$(this).tablesorter()