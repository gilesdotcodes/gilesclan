class BiographyEventsController < ApplicationController

  before_action :fetch_event, only: [:show, :edit, :update, :destroy]
  before_action :get_referrer, only: [:new, :show]

  def home
    @all = params[:all].to_i == 1 ? true : false
    if @all
      @events_this_month = BiographyEvent.this_month.latest_first
    else
      @events_this_month = BiographyEvent.this_month.shuffle.take(5).sort_by(&:start_date).reverse
    end
  end

  def index
    check_params(params)
    search_params(@params)
    tags_params(@params)
  end

  def show
    @giles_clan_ids = get_giles_clan_ids(@biography_event)
  end

  def new
    @biography_event = BiographyEvent.new
  end

  def create
    @biography_event = BiographyEvent.new(biography_events_params)
    @biography_event.user = current_user
    if @biography_event.save
      flash[:notice] = "Event successfully saved!"
      if session[:come_from] == 'index'
        redirect_to biography_events_path
      else
        redirect_to biography_home_path
      end
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
      redirect_to biography_event_path(@biography_event)
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

  def random
    if BiographyEvent.send_random_notification
      flash[:notice] = "Random Email Sent!"
    else
      flash[:notice] = "There's an error!"
    end
    redirect_to biography_home_path
  end

  def daily
    if BiographyEvent.send_daily_notification
      flash[:notice] = "On This Day Email Sent!"
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

  def search_params(params)
    scope = BiographyEvent.all.latest_first
    new_scope = scope
    if params[:type_tag_ids].present?
      params[:type_tag_ids].each do |id|
        new_scope = new_scope & scope.by_type(id.to_i)
      end
    end
    if params[:person_tag_ids].present?
      params[:person_tag_ids].each do |id|
        new_scope = new_scope & scope.by_person(id.to_i)
      end
    end
    if params[:year].present?
      new_scope = new_scope & scope.by_year(params[:year].to_i)
    end
    @biography_events = new_scope.uniq
  end

  def tags_params(params)
    @tags = []
    params[:type_tag_ids].each{ |t| @tags << TypeTag.find(t.to_i).name } if params[:type_tag_ids].present?
    params[:person_tag_ids].each{ |t| @tags << PersonTag.find(t.to_i).name } if params[:person_tag_ids].present?
    @tags << params[:year] if params[:year].present?
  end

  def get_referrer
    session[:come_from] = Rails.application.routes.recognize_path(request.referrer)[:action]
  end

  def get_giles_clan_ids(event)
    return nil if event.person_tags.empty?
    ids = []
    event.person_tags.each do |person|
      user = User.find_by(first_name: person.name)
      ids << user.id unless user.nil?
    end
    ids
  end

end
