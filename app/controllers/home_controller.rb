class HomeController < ApplicationController
  def index
    if @hosted
      redirect_to chapter_path(@project.first_chapter)
    end
  end
end
