$ ->
	$("[data-can-destroy-parent]").each ->
		$(this).bind "ajax:before", (evt, xhr, settings)->
			$(this).parents($(this).attr("data-can-destroy-parent")).remove()