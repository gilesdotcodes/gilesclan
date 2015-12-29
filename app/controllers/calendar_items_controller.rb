class CalendarItemsController < ApplicationController

  before_filter :authenticate_user!

  def west_ham_index
    session[:event_type] = 'west_ham'
    @dates = CalendarItem.west_ham.descending.current
  end

  def portugal_index
    session[:event_type] = 'portugal'
    @dates = CalendarItem.portugal.descending.current
  end

  def england_index
    session[:event_type] = 'england'
    @dates = CalendarItem.england.descending.current
  end

  def index
    session[:event_type] = 'calendar'
    @dates = CalendarItem.all.descending.current
  end

  def new
    @date = CalendarItem.new
  end

  def create
    @date = CalendarItem.new(item_params)
    @date.update(event_type: session[:event_type]) unless session[:event_type] == 'calendar'
    @date.update(user: current_user)
    if @date.save
      redirect_to send("#{session[:event_type]}_items_path")
    else
      raise 'ERROR'
    end
  end

  def edit
    @date = CalendarItem.find(params[:id])
  end

  def update
    @date = CalendarItem.find(params[:id])
    @date.update(item_params)
    redirect_to send("#{session[:event_type]}_items_path")
  end

  def destroy
    @date = CalendarItem.find(params[:id])
    @date.destroy
    redirect_to :back
  end

  private

  def item_params
    params.require(:calendar_item).permit(:date_of_event, :time_of_event, :name, :location, :event_type, :note)
  end

end
