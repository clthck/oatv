function initR() {
	var pageId = document.body.getAttribute('id');

	window.R = window.R || {};

	if (R.pages && R.pages[pageId]) {
		R.pages[pageId].run();
	}
}

// We don't use $(document).ready() to make sure initR() is called first
// before conApp.initMaterialPlugins() and $(function(){}) in _base.js
$(function() {
	initR();
});

// Note that page:load is called earlier than conApp.initMaterialPlugins()
// and $(function(){}) in _base.js, which is a good news for us.
$(document).on('page:load', initR);
