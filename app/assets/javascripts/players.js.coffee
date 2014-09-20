# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery -> 
	$('#hero_id').change -> 
		e = $('#hero_id')
		hid = e.val()
		u = e.data('url') + "/hero_matches.js?hero_id=" + hid
		$.ajax
			type: 'GET',
			dataType: 'HTML', 
			url: u,
			error: (a, status, error) ->
				alert error
			success: (data, status, a) -> 
				$('#pgrid').empty().append(data)
				false