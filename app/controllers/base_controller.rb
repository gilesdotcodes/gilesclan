class BaseController < ApplicationController
  include Pagy::Backend

  def index
    @pagy, @biography_events = pagy(BiographyEvent.this_month.latest_first)
  end
end
