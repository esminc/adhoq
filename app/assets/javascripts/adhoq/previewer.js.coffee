class Previewer
  constructor: (@el)->

  init: ->
    @el.on 'click', =>
      @update()
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
