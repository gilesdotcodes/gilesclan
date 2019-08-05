class PersonTagsController < ApplicationController
  def new; end

  def create
    @person_tag = PersonTag.new(person_tags_params)
    @person_tag.save
    redirect_to biography_events_path
  end

  private

  def person_tags_params
    params.require(:person_tag).permit(:name)
  end
end
