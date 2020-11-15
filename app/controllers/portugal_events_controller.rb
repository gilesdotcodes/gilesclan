class PortugalEventsController < ApplicationController
  def index
    @year = params[:year] ? params[:year].to_i : Time.now.year
    start_date = "#{@year}-01-01"
    end_date = "#{@year}-12-31"
    @events = PortugalEvent.where(event_date: (start_date..end_date)).group_by(&:event_date)
  end

  def new; end

  def create
    portugal_events_params[:user_ids].reject(&:blank?).each do |id|
      start_date = params[:start_date].to_date
      end_date = params[:end_date].to_date
      (start_date..end_date).each do |date|
        PortugalEvent.create(user_id: id, event_date: date)
      end
    end
    redirect_to action: :index
  end

  def view_date
    @events = PortugalEvent.where(user_id: params[:user_ids]).where(event_date: params[:event_date]).order(:user_id)
    @date = @events.first.event_date
  end

  def destroy
    event = PortugalEvent.find(params[:id])
    if event.destroy
      flash[:notice] = 'Successfully deleted!'
    else
      flash[:notice] = "There's an error!"
    end
    redirect_to action: :index
  end

  private

  def portugal_events_params
    params.require(:portugal_events).permit(
      user_ids: []
    )
  end
end
