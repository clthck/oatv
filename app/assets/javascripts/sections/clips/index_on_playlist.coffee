# clips#index_on_playlist
R.pages['clips-index_on_playlist'] = do ($ = jQuery, window, document) ->
	run = ->
		
		$table = $('#clips-table')
		editor = new $.fn.dataTable.Editor
			ajax: Routes.datatables_editor_cud_on_playlist_playlist_clips_path(R.playlistId)
			table: '#clips-table'
			idSrc: 'id'
			i18n: {
				remove: { 
					button: "Remove from playlist"
					title: "Remove Clips from Playlist"
					submit: "Remove"
					confirm: {
						_: "Are you sure you want to remove %d clips from the playlist?"
						1: "Are you sure you want to remove this clip from the playlist?"
					}
				}
			}

		table = $table.DataTable
			destroy: true
			dom: "Bfrtilpr"
			ajax: Routes.playlist_clips_path(R.playlistId, format: 'json')
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
					data: 'category.name'
				}, {
					data: 'name'
				}, {
					data: 'start'
					render: (data) -> moment().startOf('year').seconds(data).format('HH:mm:ss')
				}, {
					data: 'end'
					render: (data) -> moment().startOf('year').seconds(data).format('HH:mm:ss')
				}, {
					data: 'video.match.name'
				}, {
					data: 'video.match.date'
				}
			]
			select: {
				style: 'multiple'
				selector: 'td:first-child [type="checkbox"]'
			}
			buttons: [
				{ extend: 'remove', editor: editor }
			]
			# order: [[3, 'asc']]
			rowId: 'id'

	{ run: run }
