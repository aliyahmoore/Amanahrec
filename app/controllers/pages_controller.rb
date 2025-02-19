class PagesController < ApplicationController
  def home
    @testimonials = Testimonial.where(approved: true).order(created_at: :desc)
  end

  def calendar
    @trips = Trip.all
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
