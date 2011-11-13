module LayoutHelper
  def title(page_title)
    content_for :title do
      page_title.to_s
    end
  end

  def page_title
    app_name = Settings.app_name
    content_for(:title).blank? ? app_name : "#{app_name} - #{content_for(:title)}"
  end
end