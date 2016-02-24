function initR() {
	var pageId = document.body.getAttribute('id');

	window.R = window.R || {};

	if (R.pages && R.pages[pageId]) {
		R.pages[pageId].run();
	}
}

$(document).ready(initR);
// $(document).on('page:load', initR);
