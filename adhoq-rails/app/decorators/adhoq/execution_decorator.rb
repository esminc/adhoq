module Adhoq::ExecutionDecorator
  def status_label
    content_tag :span, class: ["label", status_label_class] do
      status
    end
  end

  def status_label_class
    case status
    when "success"
      "label-success"
    when "failure"
      "label-danger"
    when "requested"
      "label-default"
    else
      "label-default"
    end
  end
end
