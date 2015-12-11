module ApplicationHelper

  def glyphicon icon, opt={}
    content_tag :span, '', {class: "glyphicon glyphicon-#{icon}", 'aria-hidden' => "true"}.merge(opt)
  end
end
