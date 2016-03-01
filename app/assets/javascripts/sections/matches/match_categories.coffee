# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

R.pages['match_categories-index'] = do ($ = jQuery, window, document) ->
	run = ->

		$table = $('#match-categories-table')
		editor = new $.fn.dataTable.Editor
			ajax: R.dataTableAjaxPath
			table: '#match-categories-table'
			idSrc: 'id'
			fields: [{
				label: 'Name'
				name: 'name'
			}]
			i18n: {
				create: { title: "Create New Category" }
				edit: { title: "Edit Category" }
			}

		table = $table.DataTable
			destroy: true
			dom: "Bfrtilpr"
			ajax: R.dataTableAjaxPath
			iDisplayLength: 10
			aLengthMenu: [ [5, 10, 25, 50, -1], [5, 10, 25, 50, "all"] ]
			columns: [
				{
					data: null
					orderable: false
					width: '15px'
					render: (data, type, row, meta) ->
						"<input type='checkbox' id='chk-cat-#{data.id}'><label for='chk-cat-#{data.id}'></label>"
				}, {
					data: 'name'
				}
			]
			select: {
				style: 'multiple'
				selector: 'td:first-child [type="checkbox"]'
			}
			buttons: [
				{ extend: 'create', editor: editor },
				{ extend: 'edit', editor: editor },
				{ extend: 'remove', editor: editor }
			]
			order: [[1, 'asc']]
			rowId: 'id'

		checkSelectedRows = ->
			if table.rows({ selected: true }).indexes().length == 1
				table.buttons('.buttons-edit').enable()
			else
				table.buttons('.buttons-edit').disable()

		table.on 'select', checkSelectedRows
		table.on 'deselect', checkSelectedRows
		$table.on 'draw.dt', checkSelectedRows

		editor.on 'postEdit', ->
			table.rows({selected: true}).deselect()

	{ run: run }
