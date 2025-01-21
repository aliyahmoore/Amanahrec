# app/controllers/media_controller.rb
class MediaController < ApplicationController
  before_action :set_medium, only: [ :show, :edit, :update, :destroy ]

  def index
    @media = Medium.all
    @medium = Medium.new
  end

  def show
  end

  def edit
  end

  def create
    @medium = Medium.new(medium_params)
    if @medium.save
      redirect_to media_path, notice: "Media post was successfully created."
    else
      # Add the errors to the flash message
      flash[:alert] = "There was an error creating the media post."
      render :index  # Instead of redirecting, render the index page again
    end
  end

  def update
    if @medium.update(medium_params)
      redirect_to media_path, notice: "Media post was successfully updated."
    else
      flash[:alert] = "There was an error updating the media post."
      render :index
    end
  end

  def destroy
    @medium = Medium.find(params[:id])
    @medium.destroy
    redirect_to media_path, notice: "Media deleted successfully."
  end

  private

  def set_medium
    @medium = Medium.find(params[:id])
  end

  def medium_params
    params.require(:medium).permit(:name, :description, :link)
  end
end
