#= require jquery
#= require jquery_ujs
#= require jquery.remotipart
#= require turbolinks
#= require underscore
#= require Materialize
#= require datatables
#= require js-routes
#= require animateCSS
#= require video.js/dist/video
#= require videojs-youtube
#= require lib/_R
#= require lib/videojs-turbolinks
#= require_self

window.R ||= {}
window.R.pages ||= {}

do ($ = jQuery, window, document) ->
	$ ->
		$turbolinksProgressBar = $('#turbolinks-progress')

		$(document)
			.on 'page:fetch', -> $turbolinksProgressBar.show()
			.on 'page:before-unload', -> $turbolinksProgressBar.hide()
			.on 'page:load', -> $turbolinksProgressBar = $('#turbolinks-progress')
