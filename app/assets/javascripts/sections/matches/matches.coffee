# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

R.pages['matches-index'] = do ($ = jQuery, window, document) ->
	run = ->

		$table = $('#matches-table')
		editor = new $.fn.dataTable.Editor
			ajax: R.dataTableAjaxPath
			table: '#matches-table'
			idSrc: 'id'
			fields: [
				{	label: 'Category', name: 'category_id', type: 'select', options: R.matchCategories }
				{	label: 'Name', name: 'name' }
				{	label: 'Date', name: 'date' }
			]
			i18n: {
				create: { title: "Add New Match", submit: "Add" }
				edit: { title: "Edit Match" }
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
					data: null
					render: (data, type, row, meta) -> data.category.name
				}, {
					data: 'name'
				}, {
					data: 'date'
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
			order: []
			rowId: 'id'

		checkSelectedRows = ->
			if table.rows({ selected: true }).indexes().length == 1
				table.buttons('.buttons-edit').enable()
			else
				table.buttons('.buttons-edit').disable()

		table.on 'select', checkSelectedRows
		table.on 'deselect', checkSelectedRows
		$table.on 'draw.dt', checkSelectedRows

		editor.on 'postEdit', -> table.rows({selected: true}).deselect()
		pikaday = undefined
		editor.on 'open', ->
			$('select', '.DTED_Lightbox_Content').material_select()
			dateField = document.getElementById('DTE_Field_date')
			unless pikaday
				pikaday = new Pikaday
					field: dateField
					format: 'DD MMMM, YYYY'
			else
				pikaday.setDate $(dateField).val()

	{ run: run }