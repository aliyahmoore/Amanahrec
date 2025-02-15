class TestimonialsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]

    def index
      @testimonials = case params[:status]
      when "approved" then Testimonial.where(approved: true).order(created_at: :desc)
      when "pending"  then Testimonial.where(approved: false).order(created_at: :desc)
      else Testimonial.order(created_at: :desc)
      end
    end


    # Form for creating a new testimonial
    def new
      @testimonial = Testimonial.new
    end

    # Create a new testimonial
    def create
      @testimonial = current_user.testimonials.build(testimonial_params)
      if @testimonial.save
        redirect_to root_path, notice: "Your testimonial has been submitted for review."
      else
        render :new
      end
    end

    private

    def testimonial_params
      params.require(:testimonial).permit(:text)
    end
end
