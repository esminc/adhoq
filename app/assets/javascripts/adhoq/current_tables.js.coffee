Adhoq.loadCurrentTableTabOnce = ($el)->
  pane = $("#{$el.attr('href')}:has(.loading)")

  pane.load(pane.find('a.loading').attr('href'))
