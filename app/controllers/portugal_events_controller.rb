class PortugalEventsController < ApplicationController
  def index
    @year = params[:year] ? params[:year].to_i : 2019
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

  def edit; end

  def update
    # if @biography_event.update(portugal_events_params)
    #   flash[:notice] = 'Event successfully edited and saved!'
    #   redirect_to biography_event_path(@biography_event)
    # else
    #   flash[:notice] = "There's an error!"
    #   render action: :edit
    # end
  end

  def destroy
    # if @biography_event.destroy
    #   flash[:notice] = 'Event successfully deleted!'
    # else
    #   flash[:notice] = "There's an error!"
    # end
    # redirect_to biography_events_path
  end

  private

  def portugal_events_params
    params.require(:portugal_events).permit(
      user_ids: []
    )
  end
end
