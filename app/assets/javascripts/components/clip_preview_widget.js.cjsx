@ClipPreviewWidget = React.createClass
  displayName: 'ClipPreviewWidget'

  getInitialState: ->
    url: @props.videoUrl
    start: @props.clipStart
    end: @props.clipEnd
    monitorClip: null
    dataSetupDeferred: "{\"techOrder\": [\"youtube\"], \"sources\": [{\"type\": \"video/youtube\", \"src\": \"#{@props.videoUrl}\"}] }"

  componentDidMount: ->
    widget = this
    $videoEl = $('#video-clip')
    video = videojs('video-clip', $videoEl.data('setup-deferred'))
    video.src @state.url
    video.currentTime @state.start
    video.on 'timeupdate', ->
      if video.currentTime() > widget.state.end
        if video.paused()
          video.currentTime widget.state.start
        else
         video.pause()

    R.ClipPreviewWidget =
      setStates: (data) ->
        widget.setState data
        video.currentTime widget.state.start
        video.pause()
      play: -> video.play()

  render: ->
    <video id="video-clip" className="video-js vjs-default-skin responsive-embed-16x9 fluid-width" controls preload="auto" data-setup-deferred="#{@state.dataSetupDeferred}">
    </video>
