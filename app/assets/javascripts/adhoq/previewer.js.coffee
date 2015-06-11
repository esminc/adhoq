class Previewer
  constructor: (@el)->

  init: ->
    @el.on 'adhoq:updatePreview', => @update()

    @el.on 'click', =>
      @el.trigger 'adhoq:updatePreview'
      false

  update: ->
    jQuery.ajax(
      type: @el.data('method'),
      url:  @el.attr('href'),
      data: {query: @source()},
      complete: (xhr)=>
        @result().html(xhr.responseText)
    )

  source: ->
    $(@el.data('source')).val()

  result: ->
    $(@el.data('result'))

Adhoq.enablePreview = ($el)->
  (new Previewer($el)).init()

Adhoq.enablePreviewKeybordShortCut= ($textarea, previewSelector)->
  $textarea.on 'keyup', (ev)->
    if(ev.ctrlKey && ev.keyCode is 82)
      $(previewSelector).trigger('adhoq:updatePreview')

    false
