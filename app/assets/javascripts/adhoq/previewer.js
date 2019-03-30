(function($) {
  var Previewer = function(el) {
    this.el = el;
  }

  Previewer.prototype.init = function() {
    var self = this;
    this.el.on('adhoq:updatePreview', function() {
      self.update()
    });

    return this.el.on('click', function() {
      self.el.trigger('adhoq:updatePreview');
      return false;
    });
  }

  Previewer.prototype.update = function() {
    var self = this;
    return jQuery.ajax({
      type: this.el.data('method'),
      url:  this.el.attr('href'),
      data: {query: this.source()},
      complete: function(xhr) {
        return self.result().html(xhr.responseText);
      }
    });
  }

  Previewer.prototype.source = function() {
    return $(this.el.data('source')).val();
  }

  Previewer.prototype.result = function() {
    return $(this.el.data('result'));
  }

  Adhoq.enablePreview = function($el) {
    (new Previewer($el)).init()
  }

  Adhoq.enablePreviewKeybordShortCut = function($textarea, previewSelector) {
    $textarea.on('keyup', function(ev){
      if(ev.ctrlKey && (ev.keyCode === 82)) {
        $(previewSelector).trigger('adhoq:updatePreview');
      }

      return false;
    })
  }
})(jQuery);

