class MediaMentionsController < ApplicationController
  before_action :set_media_mention, only: [ :show, :edit, :update, :destroy ]

  def index
    @media_mentions = MediaMention.all
  end

  def show
    @media_mention
  end

  def edit
    @media_mention
  end

  def new
    @media_mention = MediaMention.new
  end

  def create
    @media_mention = MediaMention.new(media_mention_params)

    if @media_mention.save
      redirect_to media_mentions_path, notice: "Media post created successfully."  # Updated to redirect to the index page
    else
      flash.now[:alert] = "There was an error creating the media post."
      render :index
    end
  end

  def update
    if @media_mention.update(media_mention_params)
      redirect_to media_mention_path(@media_mention), notice: "Media post was successfully updated."  # Updated to redirect to the specific media mention page
    else
      flash[:alert] = "There was an error updating the media post."
      render :edit
    end
  end

  def destroy
    @media_mention.destroy
    redirect_to media_mentions_path, notice: "Media mention deleted successfully."  # Redirecting to the index after deletion
  end

  private

  def set_media_mention
    @media_mention = MediaMention.find(params[:id])
  end

  def media_mention_params
    params.require(:media_mention).permit(:name, :link, :published_date, :organization_name)
  end
end
