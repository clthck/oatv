window.App ||= {}

class App.ClipSearch
  constructor: ->

    $('#clips-table').on 'click', '.preview-clip', ->
      CPW = R.ClipPreviewWidget
      return unless CPW?
      CPW.setStates start: $(@).data('clip-start'), end: $(@).data('clip-end')
      CPW.play()

    # Make clip preview panel sticky
    $clipPreviewPanelEl = $('#clip-preview-panel')
    $clipPreviewPanelEl.data 'original-offset', $clipPreviewPanelEl.offset()
    $clipsTablePanelEl = $('#clips-table').parents('.card-panel')
    $('body.nano').on 'update', (e, v) ->
      offset = $clipPreviewPanelEl.offset()
      offset.top = if v.position > 274
        80
      else if v.position < 10 and v.direction is 'up'
        $clipPreviewPanelEl.data('original-offset').top
      else
        $clipsTablePanelEl.offset().top
      $clipPreviewPanelEl.offset offset

$(document).on "ready page:load", ->
  return unless ($("#clips-search").length > 0)
  new App.ClipSearch
