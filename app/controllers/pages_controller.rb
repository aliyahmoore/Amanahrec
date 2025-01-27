class PagesController < ApplicationController
  def home
  end

  def calendar
    @events = Event.all
  end

  def about
  end

  def partners
  end
end
