# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Helper class
class ClipsHelper
	@initDataTable: ->
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
				loadingRecords: """
												<div class="preloader-wrapper active">
													<div class="spinner-layer spinner-blue">
														<div class="circle-clipper left"><div class="circle"></div></div>
														<div class="gap-patch"><div class="circle"></div></div>
														<div class="circle-clipper right"><div class="circle"></div></div>
													</div>
													<div class="spinner-layer spinner-red">
														<div class="circle-clipper left"><div class="circle"></div></div>
														<div class="gap-patch"><div class="circle"></div></div>
														<div class="circle-clipper right"><div class="circle"></div></div>
													</div>
													<div class="spinner-layer spinner-yellow">
														<div class="circle-clipper left"><div class="circle"></div></div>
														<div class="gap-patch"><div class="circle"></div></div>
														<div class="circle-clipper right"><div class="circle"></div></div>
													</div>
													<div class="spinner-layer spinner-green">
														<div class="circle-clipper left"><div class="circle"></div></div>
														<div class="gap-patch"><div class="circle"></div></div>
														<div class="circle-clipper right"><div class="circle"></div></div>
													</div>
												</div>
												"""
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
				{ extend: 'add_to_playlist', editor: editor }
			]
			order: [[3, 'asc']]
			rowId: 'id'

		checkSelectedRows = ->
			selectedRows = table.rows({ selected: true }).count()
			table.buttons('.buttons-edit').enable(selectedRows == 1)
			table.buttons('.buttons-add-to-playlist').enable(selectedRows > 0)

		table.on 'select', checkSelectedRows
		table.on 'deselect', checkSelectedRows
		$table.on 'draw.dt', checkSelectedRows

		editor.on 'postEdit', -> table.rows({selected: true}).deselect()
		.on 'open', ->
			$('select', '.DTED_Lightbox_Content').material_select()
			$('#DTE_Field_start').val moment().startOf('year').seconds($('#DTE_Field_start').val().replace(':', '')).format('HH:mm:ss')
			$('#DTE_Field_end').val moment().startOf('year').seconds($('#DTE_Field_end').val().replace(':', '')).format('HH:mm:ss')

# clips#index
R.pages['clips-index'] = do ($ = jQuery, window, document) ->
	run = ->

		$playlistsPopup = $('#playlists-popup')

		$.fn.dataTable.ext.buttons.add_to_playlist = {
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
		}

		$('form', $playlistsPopup).on 'ajax:success', ->
			$playlistsPopup.closeModal()

		ClipsHelper.initDataTable()
	{ run: run }
