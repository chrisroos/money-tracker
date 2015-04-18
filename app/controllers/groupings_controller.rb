class GroupingsController < ApplicationController
  def search
    groupings = Grouping.search(params[:term])
    render json: groupings
  end
end
