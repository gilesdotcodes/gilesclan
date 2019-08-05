class BaseController < ApplicationController
  def index
    @events = BiographyEvent.this_month.latest_first
  end
end
