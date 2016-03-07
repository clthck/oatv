# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Helper class
class ClipsHelper
	@initClipsDataTable: ->
		$table = $('#clips-table')
		editor = new $.fn.dataTable.Editor
			ajax: Routes.datatables_editor_cud_match_video_clips_path(R.matchId, R.videoId)
			table: '#clips-table'
			idSrc: 'id'
			fields: [
				{	label: 'Category', name: 'category_id', type: 'select', options: R.clipCategories }
				{	label: 'Name', name: 'name' }
				{	label: 'Start', name: 'start', type: 'mask', mask: '00:00:00', placeholder: '__:__:__' }
				{	label: 'End', name: 'end', type: 'mask', mask: '00:00:00', placeholder: '__:__:__' }
			]
			i18n: {
				create: { title: "Add New Clip", submit: "Add" }
				edit: { title: "Edit Clip" }
			}

		table = $table.DataTable
			destroy: true
			dom: "Bfrtilpr"
			ajax: Routes.match_video_clips_path(R.matchId, R.videoId, format: 'json')
			language: {
				loadingRecords: R.dtLoadingRecords
			}
			iDisplayLength: 10
			aLengthMenu: [ [5, 10, 25, 50, -1], [5, 10, 25, 50, "all"] ]
			columns: [
				{
					data: null, orderable: false, width: '15px'
					render: (data, type, row, meta) ->
						"<input type='checkbox' id='chk-cat-#{data.id}'><label for='chk-cat-#{data.id}'></label>"
				}, {
					data: null
					render: (data, type, row, meta) -> data.category.name
				}, {
					data: 'name'
				}, {
					data: 'start'
					render: (data) -> moment().startOf('year').seconds(data).format('HH:mm:ss')
				}, {
					data: 'end'
					render: (data) -> moment().startOf('year').seconds(data).format('HH:mm:ss')
				}
			]
			select: {
				style: 'multiple'
				selector: 'td:first-child [type="checkbox"]'
			}
			buttons: [
				{ extend: 'create', editor: editor }
				{ extend: 'edit', editor: editor }
				{ extend: 'remove', editor: editor }
				'add_to_playlist'
				'assign_to_players'
			]
			order: [[3, 'asc']]
			rowId: 'id'

		checkSelectedRows = ->
			selectedRows = table.rows({ selected: true }).count()
			table.buttons('.buttons-edit').enable(selectedRows == 1)
			table.buttons('.buttons-add-to-playlist').enable(selectedRows > 0)
			table.buttons('.buttons-assign-to-players').enable(selectedRows > 0)

		table.on 'select', checkSelectedRows
		table.on 'deselect', checkSelectedRows
		$table.on 'draw.dt', checkSelectedRows

		editor.on 'postEdit', -> table.rows({selected: true}).deselect()
		.on 'open', ->
			$('select', '.DTED_Lightbox_Content').material_select()
			$('#DTE_Field_start').val moment().startOf('year').seconds($('#DTE_Field_start').val().replace(':', '')).format('HH:mm:ss')
			$('#DTE_Field_end').val moment().startOf('year').seconds($('#DTE_Field_end').val().replace(':', '')).format('HH:mm:ss')

	@initPlayersDataTable: ->
		table = $('#players-table').DataTable
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
				'assign_clips_to_players'
			]
			order: []
			rowId: 'id'

		checkSelectedRows = ->
			selectedRows = table.rows({ selected: true }).count()
			table.buttons('.buttons-assign-clips-to-players').enable(selectedRows > 0)

		table.on 'select', checkSelectedRows
		table.on 'deselect', checkSelectedRows

# clips#index
R.pages['clips-index'] = do ($ = jQuery, window, document) ->
	run = ->

		$playlistsPopup = $('#playlists-popup')
		$playersPopup = $('#players-popup')

		$.fn.dataTable.ext.buttons.add_to_playlist =
			text: 'Add to Playlist'
			action: (e, dt, node, config) ->
				selectedRows = dt.rows({selected: true})
				$('[type=submit]', $playlistsPopup).text "Add #{selectedRows.count()} clips to playlist"
				$('#data_clip_ids').val _.map(selectedRows.data(), (o) -> o.id).join()
				$playlistsPopup.openModal {
					dismissible: true
				}
			enabled: no
			className: 'buttons-add-to-playlist blue'

		$.fn.dataTable.ext.buttons.assign_to_players =
			text: 'Assign to Players'
			action: (e, dt, node, config) ->
				$playersPopup.openModal()
			enabled: no
			className: 'buttons-assign-to-players blue'

		$.fn.dataTable.ext.buttons.assign_clips_to_players =
			text: 'Assign Clips to Players'
			action: (e, dt, node, config) ->
				selectedClips = $('#clips-table').DataTable().rows({selected: true})
				selectedPlayers = dt.rows({selected: true})
				$('#clip_ids').val _.map(selectedClips.data(), (o) -> o.id).join()
				$('#player_ids').val _.map(selectedPlayers.data(), (o) -> o.id).join()
				$('form', $playersPopup).submit().one 'ajax:success', ->
					$playersPopup.closeModal()
					dt.rows({selected: true}).deselect()
					$('input:checked', '#players-table').prop 'checked', no
			enabled: no
			className: 'buttons-assign-clips-to-players blue'

		$('form', $playlistsPopup).on 'ajax:success', -> $playlistsPopup.closeModal()

		ClipsHelper.initClipsDataTable()
		ClipsHelper.initPlayersDataTable()
	{ run: run }
