module Api
  class EventsController < ActionController::API
    include ActionController::HttpAuthentication::Basic::ControllerMethods

    http_basic_authenticate_with name: Rails.application.credentials.api_name, password: Rails.application.credentials.api_password

    def index
      @events = BiographyEvent.includes(:person_tags, :type_tags, :user).references(:person_tags, :type_tags, :user)

      render json: @events
    end

    def show
      @event = BiographyEvent.find_by(id: params[:id])

      render json: @event
    end
  end
end
