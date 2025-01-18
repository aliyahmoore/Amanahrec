class MediaController < ApplicationController
  before_action :set_medium, only: [ :update, :destroy ]

  def index
    @media = Medium.all
  end

  def show
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
      # Add the errors to the flash message
      flash[:alert] = "There was an error updating the media post."
      render :index  # Instead of redirecting, render the index page again
    end
  end

  def destroy
    @medium.destroy
    redirect_to media_path, notice: "Media post was successfully deleted."
  end

  private

  def set_medium
    @medium = Medium.find(params[:id])
  end

  def medium_params
    params.require(:medium).permit(:name, :description, :link)
  end
end
