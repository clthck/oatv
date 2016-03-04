# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# videos#new
R.pages['videos-new'] = do ($ = jQuery, window, document) ->
	run = ->
		
		$('#new_video').on 'submit', (e) ->
			$(this).materialBlock()

		.on 'ajax:success', ->
			$(this).materialUnblock()

	{ run: run }
