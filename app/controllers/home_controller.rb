class HomeController < ApplicationController
  def index
    @testimonials = Testimonial.where(approved: true).order(created_at: :desc)
    render "pages/home"
  end
end
