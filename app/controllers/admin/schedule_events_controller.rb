# encoding: utf-8

class Admin::ScheduleEventsController < Admin::AdminController

  def load_schedule_event
    @schedule_event = ScheduleEvent.find(params[:id]) rescue nil
    unless @schedule_event
      flash[:notice] = "Could not find event with ID ##{params[:id]}"
      redirect_to admin_schedule_events_url and return
    end
  end
  protected     :load_schedule_event
  before_action :load_schedule_event, :only => [:show, :edit, :update, :destroy]


  def index
    @year            = params[:year] || Date.current.year
    @years           = ScheduleEvent.years
    @years           = [Date.current.year] unless @years.length > 0
    @schedule_events = ScheduleEvent.by_year(@year).sorted
  end

  def show
    render :action => :edit
  end

  def new
    @schedule_event = ScheduleEvent.new
  end

  def create
    @schedule_event = ScheduleEvent.create(schedule_event_params)
    if @schedule_event.valid?
      flash[:notice] = "New event created"
      redirect_to admin_schedule_events_by_year_url(:year => @schedule_event.year) and return
    else
      render :action => :new
    end
  end

  def edit
  end

  def update
    if @schedule_event.update_attributes(schedule_event_params)
      flash[:notice] = "Event was updated"
      redirect_to admin_schedule_events_by_year_url(:year => @schedule_event.year) and return
    else
      render :action => :edit
    end
  end

  def destroy
    @schedule_event.destroy
    flash[:notice] = "Event was deleted"
    redirect_to admin_schedule_events_url and return
  end

  private

  def schedule_event_params
    params.require(:schedule_event).permit(:name, :location, :link, :starts_at,
                                           :ends_at, :image, :published)
  end

end
