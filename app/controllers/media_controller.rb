class MediaController < ApplicationController
  before_action :set_medium, only: [ :update, :destroy ]

  def index
    @media = Medium.all
  end

  def show
  end

  def new
    @medium = Medium.new
  end

  def create
    @medium = Medium.new(medium_params)
    if @medium.save
      redirect_to @medium, notice: "Media post was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @medium.update(medium_params)
      redirect_to @medium, notice: "Media post was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @medium.destroy
    redirect_to media_url, notice: "Media post was successfully deleted."
  end

  private

  # Set the medium for the actions that require it
  def set_medium
    @medium = Medium.find(params[:id])
  end

  # Permit only title, description, and URL parameters for media posts
  def medium_params
    params.require(:medium).permit(:title, :description, :url)
  end
end
