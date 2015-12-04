module ApplicationHelper

  def glyphicon icon, opt={}
    content_tag :span, '', {class: "glyphicon glyphicon-#{icon}"}.merge(opt)
  end
end
