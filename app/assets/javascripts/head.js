//= require jquery
//= require jquery_ujs
//= require jquery.remotipart
//= require turbolinks
//= require underscore
//= require Materialize
//= require datatables
//= require js-routes
//= require animateCSS
//= require _R
//= require_self

window.R = window.R || {};
window.R.pages = window.R.pages || {};

(function ($, window, document) {

	$(function () {

		var $turbolinksProgressBar = $(document.getElementById('turbolinks-progress'));

		$(document).on('page:fetch', function () {
			$turbolinksProgressBar.show();
		});

		$(document).on('page:before-unload', function () {
			$turbolinksProgressBar.hide();
		});

		$(document).on('page:load', function () {
			$turbolinksProgressBar = $(document.getElementById('turbolinks-progress'));
		});

	});

}) (jQuery, window, document);
