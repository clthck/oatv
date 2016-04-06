R.pages['users-list_players'] = do ($ = jQuery, window, document) ->
  run = ->

    # DataTable for players-table
    playersTable = $('#players-table').DataTable
      dom: "lfrtipr"
      ajax: Routes.players_clubs_path(format: 'json')
      language: {
        loadingRecords: R.dtLoadingRecords
      }
      iDisplayLength: 10
      bLengthChange: on
      # scrollY: '151px'
      # scrollCollapse: yes
      deferRender: yes
      columns: [
        {
          data: null
          render: (data, type, row, meta) -> "<img class='avatar circle small' alt='#{data.full_name}' src='#{data.avatar_url_thumb}'>"
        }
        {
          data: null
          render: (data, type, row, meta) -> "<a href='#{Routes.user_path(data.id)}'>#{data.full_name}</a>"
        }
      ]
      order: []
      rowId: 'id'
      columnDefs: [
        { targets: [0], orderable: false }
      ]

  { run: run }