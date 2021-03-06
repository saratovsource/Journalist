module Timeline
  class TimelinesController < ::BaseController

    layout "journalist_timeline"

    def index
      @calendar_builder = Journalist::CalendarBuilder.new(calendar_options)
      @items = current_site.time_lines.feed(params[:date].try(:to_date))
      @items = tabs_filter(@items, params[:tab]).page(params[:page]).per(params[:per]).map(&:timelinable).compact
      if @items.any?
        @layout_sections = {
          :main_menu => {
            :name => "journalist/timeline",
            :action => :description
          },
          :timeline => {
            :name => "journalist/timeline",
            :action => :dayline,
            :options => {:days => @calendar_builder}
          },
          :sidebar => {
            :name => "journalist/faces_navigation",
            :action => :widget,
            :options => {:current_site => current_site}
          }
        }
      else
        Slowpoke.create(:site => current_site)
        @layout_sections = {
          :main_menu => {
            :name => "journalist/slowtime",
            :action => :description
          }}
        render "slowtime", :status => 404
      end
    end

    def sections
      [:timeline]
    end

    protected

    def calendar_options
      {
        :day => params[:date].present? ? params[:date].to_date : Date.today,
        :count => 10,
        :site => current_site
      }
    end

  end
end
