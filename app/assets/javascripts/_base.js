(function (init) {

	init(window.jQuery, window, document);

})(function($, window, document) {

	var $bodyEl = $('body'),
		inputOldValue, $sideNav;

	/**
	 * Define custom event 'changeBlur' for form input elements
	 */
	$bodyEl.on('focus', 'input, textarea, select', function () {
		inputOldValue = $(this).val();
	});
	$bodyEl.on('blur', 'input, textarea, select', function () {
		if (inputOldValue != $(this).val()) {
			$(this).trigger('changeBlur');
		}
	});

	/**
	 * Materialize blockUI
	 */
	$.fn.extend({
		materialBlock: function (options) {
			this.each(function () {
				$(this).block($.extend( {}, {
					message: '<div class="preloader-wrapper small active"><div class="spinner-layer spinner-green-only"><div class="circle-clipper left"><div class="circle"></div></div><div class="gap-patch"><div class="circle"></div></div><div class="circle-clipper right"><div class="circle"></div></div></div></div>',
					overlayCSS: { opacity: 0.1 },
					css: {
						border: 'none',
						backgroundColor: 'transparent',
					}
				}, options ));
			});
			return this;
		}
	});

	/**
	 * jQuery DOM document ready event handler
	 */
	$(function() {

		// $.fn.sideNav && $('.button-collapse').sideNav();
		// $.fn.parallax && $('.parallax').parallax();
		// $.fn.leanModal && $('.modal-trigger').leanModal();

		// $.fn.material_select && $('select').material_select();
		// $.fn.pickadate && $('.datepicker').pickadate({
		// 	selectMonths: true,
		// 	selectYears: 15,
		// 	closeOnSelect: true,
		// 	closeOnClear: true,
		// 	format: 'mmmm d, yyyy',
		// 	formatSubmit: 'yyyy-mm-dd',
		// 	hiddenName: true
		// });

		$.fn.nanoScroller && $('.nano').nanoScroller();

		// For compatibility with turbolinks
		Waves.displayEffect();
		Materialize.updateTextFields();

		// Relocate .error-message for .file-field
		$('.file-field').each(function () {
			var $this = $(this);
			$('input[type="file"] ~ .error-message', $this).appendTo($this);
		});

		// Open corresponding side nav menu with active child item
		$sideNav = $(document.getElementById('side-nav'));
		$sideNav.find('li.active').parents('ul').parents('li').addClass('open');

		// Materialize dataTable Editor buttons
		$('.dt-buttons').addClass('btn-group');
		$('.dt-button').addClass('btn btn-rounded waves-effect waves-light');
		$('.dataTables_length').addClass('ml-20');

	});

});
