class MediaMentionsController < ApplicationController
  def index
    @media_mentions = MediaMention.order(published_date: :desc)
  end
end
