class PagesController < ApplicationController
  def home
    @testimonials = Testimonial.where(approved: true).order(created_at: :desc)
  end

  def calendar
    @events = Event.all
    @activities = Activity.all
  end

  def about
    @about = About.first
  end

  def partners
    @partners = Partner.all
  end

  def sponsors
    @sponsors = Sponsor.all
  end
  
end
