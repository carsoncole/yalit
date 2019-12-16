class TestapiController < ApplicationController
  before_action :require_login
  before_action :set_chapter

  layout 'chapters'
  def index
    @api_key = cookies[:api_key] if cookies[:api_key].present?
    @endpoints =[]
    @chapter.sections.where(is_resource: true).each do |s|
      s.request_methods.each do |rm|
        @endpoints << ["#{rm.section.title}: #{rm.title}", rm.id]
      end
    end
  end

  def set_api_key_cookie
    cookies[:api_key] = params[:api_key]
    redirect_to testapi_path
  end

  private
    def set_chapter
      @chapter = Chapter.find(params[:chapter_id]) if params[:chapter_id]
    end
end
