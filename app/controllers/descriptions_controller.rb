# encoding: utf-8

class DescriptionsController < ApplicationController
  def search
    descriptions = Description.search(params[:term])
    render json: descriptions
  end
end