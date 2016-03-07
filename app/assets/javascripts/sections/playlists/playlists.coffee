# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

R.pages['playlists-index'] = do ($ = jQuery, window, document) ->
	run = ->

		$table = $('#playlists-table')
		$playersPopup = $('#players-popup')

		$.fn.dataTable.ext.buttons.assign_to_players =
			text: 'Assign to Players'
			action: (e, dt, node, config) ->
				$playersPopup.openModal()
			enabled: no
			className: 'buttons-assign-to-players blue'

		$.fn.dataTable.ext.buttons.assign_playlists_to_players =
			text: 'Assign Playlists to Players'
			action: (e, dt, node, config) ->
				selectedPlaylists = $('#playlists-table').DataTable().rows({selected: true})
				selectedPlayers = dt.rows({selected: true})
				$('#playlist_ids').val _.map(selectedPlaylists.data(), (o) -> o.id).join()
				$('#player_ids').val _.map(selectedPlayers.data(), (o) -> o.id).join()
				$('form', $playersPopup).submit().one 'ajax:success', ->
					$playersPopup.closeModal()
					dt.rows({selected: true}).deselect()
					$('input:checked', '#players-table').prop 'checked', no
			enabled: no
			className: 'buttons-assign-playlists-to-players blue'

		# DataTable Editor for playlists-table
		editor = new $.fn.dataTable.Editor
			ajax: Routes.datatables_editor_cud_playlists_path()
			table: '#playlists-table'
			idSrc: 'id'
			fields: [{
				label: 'Name'
				name: 'name'
			}]
			i18n: {
				create: { title: "Create New Playlist" }
				edit: { title: "Edit Playlist" }
			}

		table = $table.DataTable
			destroy: true
			dom: "Bfrtilpr"
			ajax: Routes.playlists_path(format: 'json')
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
				}, {
					data: null
					render: (data) -> "<a href='#{Routes.playlist_clips_path(data.id)}'>View Clips</a> (#{data.clips_count})"
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
				'assign_to_players'
			]
			order: [[1, 'asc']]
			rowId: 'id'

		checkSelectedRows = ->
			selectedRows = table.rows({ selected: true }).count()
			table.buttons('.buttons-edit').enable(selectedRows == 1)
			table.buttons('.buttons-assign-to-players').enable(selectedRows > 0)

		table.on 'select', checkSelectedRows
		table.on 'deselect', checkSelectedRows
		$table.on 'draw.dt', checkSelectedRows

		editor.on 'postEdit', ->
			table.rows({selected: true}).deselect()

		# DataTable for players-table
		playersTable = $('#players-table').DataTable
			dom: "BfrtilrS"
			ajax: Routes.players_clubs_path(format: 'json')
			language: {
				loadingRecords: R.dtLoadingRecords
			}
			iDisplayLength: 5
			bLengthChange: off
			scrollY: '151px'
			# scrollCollapse: yes
			deferRender: yes
			columns: [
				{
					data: null, orderable: false, width: '15px'
					render: (data, type, row, meta) ->
						"<input type='checkbox' id='chk-cat-#{data.id}'><label for='chk-cat-#{data.id}'></label>"
					className: 'checkbox-td'
				}, {
					data: null
					render: (data, type, row, meta) -> "<img class='avatar circle' alt='#{data.full_name}' src='#{data.avatar_url_thumb}'>#{data.full_name}"
				}
			]
			select: {
				style: 'multiple'
				selector: 'td:first-child [type="checkbox"]'
			}
			buttons: [
				'assign_playlists_to_players'
			]
			order: []
			rowId: 'id'

		checkSelectedRows = ->
			selectedRows = playersTable.rows({ selected: true }).count()
			playersTable.buttons('.buttons-assign-playlists-to-players').enable(selectedRows > 0)

		playersTable.on 'select', checkSelectedRows
		playersTable.on 'deselect', checkSelectedRows

	{ run: run }
