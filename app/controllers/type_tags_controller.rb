class TypeTagsController < ApplicationController

  def new
  end

  def create
    @type_tag = TypeTag.new(type_tags_params)
    @type_tag.save
    redirect_to biography_home_path
  end

  private

  def type_tags_params
    params.require(:type_tag).permit(:name)
  end

end
