loadCurrentTableTabOnce = ($el)->
  $el.load($el.find('a.loading').attr('href'))

Adhoq.toggleCurrentTables = (action, elements)->
  loadCurrentTableTabOnce($('#current-tables'))

  $main   = $(elements.main)
  $tables = $(elements.tables)

  if action is 'show'
    $main.addClass('col-md-6').removeClass('col-md-12')
    $tables.addClass('col-md-6').show()
  else
    $main.addClass('col-md-12').removeClass('col-md-6')
    $tables.addClass('col-md-6').hide()

  true

