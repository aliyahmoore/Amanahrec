class PagesController < ApplicationController
  def home
    @testimonials = Testimonial.where(approved: true).order(created_at: :desc)
    @gallery_images = Dir.glob("app/assets/images/gallery/*").map { |img| ActionController::Base.helpers.asset_path(img.gsub("app/assets/images/", "")) }
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

  def boards
    @boards = Board.all
  end

  def media_mentions
    @media_mentions = MediaMention.order(published_date: :desc)
  end
end
