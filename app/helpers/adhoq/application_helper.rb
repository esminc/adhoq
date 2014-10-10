module Adhoq
  module ApplicationHelper
    def human(klass, attr = nil)
      if attr
        klass.human_attribute_name(attr)
      else
        klass.model_name.humanize
      end
    end

    def icon_fa(name, additional_classes = [])
      tag('i', class: ['fa', "fa-#{name}", *additional_classes])
    end
  end
end
