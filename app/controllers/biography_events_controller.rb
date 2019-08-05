class BiographyEventsController < ApplicationController
  include GilesClanIds
  include Pagy::Backend

  before_action :fetch_event, only: [:show, :edit, :update, :destroy]

  def index
    @pagy, @biography_events = pagy(biography_events)
  end

  def show
    @giles_clan_ids = User.linked_giles_clan(@biography_event.person_tags.pluck(:name)).pluck(:id)
  end

  def new
    @biography_event = BiographyEvent.new
  end

  def create
    @biography_event = BiographyEvent.new(biography_events_params)
    @biography_event.user = current_user
    if @biography_event.save
      flash[:notice] = 'Event successfully saved!'
      redirect_to biography_event_path(@biography_event)
    else
      flash[:notice] = "There's an error!"
      render action: :new
    end
  end

  def edit; end

  def update
    if @biography_event.update(biography_events_params)
      flash[:notice] = 'Event successfully edited and saved!'
      redirect_to biography_event_path(@biography_event)
    else
      flash[:notice] = "There's an error!"
      render action: :edit
    end
  end

  def destroy
    if @biography_event.destroy
      flash[:notice] = 'Event successfully deleted!'
    else
      flash[:error] = "There's an error!"
    end
    redirect_to biography_events_path
  end

  def random
    if BiographyEvent.send_random_notification
      flash[:notice] = "Random Email Sent!"
    else
      flash[:notice] = "There's an error!"
    end
    redirect_to biography_events_path
  end

  def daily
    if BiographyEvent.send_daily_notification
      flash[:notice] = "On This Day Email Sent!"
    else
      flash[:notice] = "There's an error!"
    end
    redirect_to biography_events_path
  end

  def summary
    if BiographyEvent.send_daily_summary_notification
      flash[:notice] = "On This Day Summary Email Sent!"
    else
      flash[:notice] = "There's an error!"
    end
    redirect_to biography_events_path
  end

  private

  def biography_events_params
    params.require(:biography_event).permit(
      :title, :description, :start_date, :end_date, :location,
      person_tag_ids: [], type_tag_ids: []
    )
  end

  def fetch_event
    @biography_event = BiographyEvent.find(params[:id])
  end

  def filter_params
    return false unless params[:filters]
    @filter_params ||=  {}.tap do |hsh|
                          hsh[:type_ids] = params[:filters][:type_tag_ids].reject(&:blank?)
                          hsh[:person_ids] = params[:filters][:person_tag_ids].reject(&:blank?)
                          hsh[:year] = params[:filters][:year]
                        end
  end

  def set_filter_tags
    @tags ||= [].tap do |arr|
                filter_params[:type_ids].each{ |id| arr << TypeTag.find(id).name }
                filter_params[:person_ids].each{ |id| arr << PersonTag.find(id).name }
                arr << filter_params[:year] if filter_params[:year].present?
                arr << 'No filters selected' if arr.empty?
              end
  end

  def biography_events
    if filter_params
      set_filter_tags
      BiographyEvent.latest_first
        .then { |events| filter_params[:type_ids].any? ? events.by_type(filter_params[:type_ids]) : events }
        .then { |events| filter_params[:person_ids].any? ? events.by_person(filter_params[:person_ids]) : events }
        .then { |events| filter_params[:year].present? ? events.by_year(filter_params[:year]) : events }
    else
      BiographyEvent.order(created_at: :desc).limit(100)
    end
  end
end
