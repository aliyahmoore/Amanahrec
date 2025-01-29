class PagesController < ApplicationController
  def home
    @testimonials = Testimonial.where(approved: true).order(created_at: :desc)
  end

  def calendar
    @events = Event.where("start_date >= ? AND start_date <= ?", Date.today.beginning_of_month, Date.today.end_of_month)
    @activities = Activity.where("date >= ? AND date <= ?", Date.today.beginning_of_month, Date.today.end_of_month)
  end

  def about
  end

  def partners
  end

  def board
  end
end
