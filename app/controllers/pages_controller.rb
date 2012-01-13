class PagesController < ApplicationController
  before_filter :force_request_format_to_html

  def index
  end

  private

  def force_request_format_to_html
    request.format = :html
  end
end
