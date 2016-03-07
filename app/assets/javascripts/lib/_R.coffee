initR = ->
	pageId = document.body.getAttribute('id')
	window.R ||= {}
	R.pages[pageId].run() if R.pages and R.pages[pageId]

###
We don't use $(document).ready() to make sure initR() is called first
before conApp.initMaterialPlugins() and $(function(){}) in _base.js
###
$ -> initR()

###
Note that page:load is called earlier than conApp.initMaterialPlugins()
and $(function(){}) in _base.js, which is a good news for us.
###
$(document).on 'page:load', initR
