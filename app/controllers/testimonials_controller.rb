class TestimonialsController < ApplicationController
    before_action :authenticate_user!, except: [:index]
    before_action :set_testimonial, only: [:edit, :update, :destroy, :approve]
    before_action :authorize_admin!, only: [:approve, :destroy]
  
    # Display approved testimonials to everyone and unapproved to admin
    def index
        if current_user&.role&.name == 'admin'
            @testimonials = Testimonial.order(created_at: :desc)
          else
            @testimonials = Testimonial.where(approved: true).order(created_at: :desc)
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
        redirect_to testimonials_path, notice: "Your testimonial has been submitted for review."
      else
        render :new
      end
    end
  
    # Admin: Approve a testimonial
    def approve
      @testimonial.update(approved: true)
      redirect_to testimonials_path, notice: "Testimonial approved successfully."
    end
  
    # Admin or User: Edit a testimonial
    def edit
    end
  
    # Update a testimonial
    def update
      if @testimonial.update(testimonial_params)
        redirect_to testimonials_path, notice: "Testimonial updated successfully."
      else
        render :edit
      end
    end
  
    # Admin: Delete a testimonial
    def destroy
      @testimonial.destroy
      redirect_to testimonials_path, notice: "Testimonial deleted successfully."
    end
  
    private
  
    def testimonial_params
      params.require(:testimonial).permit(:text)
    end
  
    def set_testimonial
      @testimonial = Testimonial.find(params[:id])
    end
  
    def authorize_admin!
        redirect_to root_path, alert: "Not authorized!" unless current_user&.role&.name == 'admin'

    end
  end
  