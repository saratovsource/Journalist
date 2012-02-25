$ ->
	$('[data-media-account]').each ->
		$(this).change ->
			current_user = $(this).val()
			post_path = [$(this).data("media-account"), current_user, $(this).data("postfix")].join('/')
			$('form[data-change-user]').each ->
				$(this).attr('action', post_path)
				$(this).submit()