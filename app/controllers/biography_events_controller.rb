class BiographyEventsController < ApplicationController

  before_action :fetch_event, only: [:show, :edit, :update, :destroy]

  def home
    @events_this_month = BiographyEvent.this_month.latest_first
  end

  def index
    check_params(params)
    scope = BiographyEvent.all.latest_first
    scope = scope.types(@params[:type_tag_ids].map(&:to_i)) if @params[:type_tag_ids].present?
    scope = scope.persons(@params[:person_tag_ids].map(&:to_i)) if @params[:person_tag_ids].present?
    @biography_events = scope.uniq
  end

  def show
  end

  def new
    @biography_event = BiographyEvent.new
  end

  def create
    @biography_event = BiographyEvent.new(biography_events_params)
    if @biography_event.save
      flash[:notice] = "Event successfully saved!"
      redirect_to biography_home_path
    else
      flash[:notice] = "There's an error!"
      render action: :new
    end
  end

  def edit
  end

  def update
    if @biography_event.update(biography_events_params)
      flash[:notice] = "Event successfully edited and saved!"
      redirect_to biography_home_path
    else
      flash[:notice] = "There's an error!"
      render action: :edit
    end
  end

  def destroy
    if @biography_event.destroy
      flash[:notice] = "Event successfully deleted!"
    else
      flash[:notice] = "There's an error!"
    end
    redirect_to biography_home_path
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

  def check_params(params)
    @params = params[:filters].present? ? params[:filters] : params
    @params[:type_tag_ids].reject!(&:blank?) if @params[:type_tag_ids].present?
    @params[:person_tag_ids].reject!(&:blank?) if @params[:person_tag_ids].present?
  end

end
