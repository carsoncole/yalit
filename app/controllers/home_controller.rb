class HomeController < ApplicationController
  def index
    if @hosted
      redirect_to chapter_path(@project.first_chapter)
    end
    render layout: 'landing_page'
  end

  def not_found
  end
end
