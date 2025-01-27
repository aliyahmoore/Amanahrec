class PagesController < ApplicationController
  def home
    @testimonials = Testimonial.where(approved: true).order(created_at: :desc)
  end

  def calendar
  end

  def about
  end

  def partners
  end
end
