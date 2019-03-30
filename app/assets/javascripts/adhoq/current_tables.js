(function($) {
  var loadCurrentTableTabOnce = function($el) {
    $el.load($el.find('a.loading').attr('href'));
  };

  Adhoq.toggleCurrentTables = function(action, elements){
    loadCurrentTableTabOnce($('#current-tables'));

    var $main   = $(elements.main);
    var $tables = $(elements.tables);

    if (action === 'show') {
      $main.addClass('col-md-6').removeClass('col-md-12');
      $tables.addClass('col-md-6').show();
    } else {
      $main.addClass('col-md-12').removeClass('col-md-6');
      $tables.addClass('col-md-6').hide();
    }

    return true;
  };
})(jQuery);

