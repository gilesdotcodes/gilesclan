class CalendarItemsController < ApplicationController

  before_filter :authenticate_user!

  def west_ham_index
    @dates = CalendarItem.west_ham.descending
  end

  def portugal_index
  end

  def index
  end

  def new
    @date = CalendarItem.new
  end

  def create
    @date = CalendarItem.new(item_params)
    @date.update(event_type: 'west_ham')
    if @date.save
      redirect_to west_ham_dates_path  # temp!
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
    redirect_to west_ham_dates_path # temp!
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
