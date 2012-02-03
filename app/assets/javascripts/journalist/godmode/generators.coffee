random_password = (length = 8) ->
  c = "b c d f g h j k l m n p 1 r s t v w x z 2 3 4 6 6 7 8 9 0 A Z F T H W B".split " "
  v = "a e i o u y".split " "
  f = true
  r = ""
  for t in [1..length]
    r += if f then c[Math.round(Math.random(1) * c.length-1)] else v[Math.round(Math.random(1) * v.length-1)]
    f = not f
  r


$ ->
	$('[data-password-generator]').each ->
		target_inp = $(this).attr('data-password-generator')
		$(this).bind "click", ->
			$(this).siblings("[#{target_inp}]").val random_password(8)
			false