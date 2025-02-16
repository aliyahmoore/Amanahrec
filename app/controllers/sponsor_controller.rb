class SponsorController < ApplicationController
  def index
    @sponsor = Sponsor.all
  end
end
