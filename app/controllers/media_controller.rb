class MediaController < ApplicationController
  def index
    @media = Medium.all
  end
end
