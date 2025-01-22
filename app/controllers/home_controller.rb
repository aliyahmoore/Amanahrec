class HomeController < ApplicationController
  def index
    @testimonials = Testimonial.where(approved: true).order(created_at: :desc)
  end
end
