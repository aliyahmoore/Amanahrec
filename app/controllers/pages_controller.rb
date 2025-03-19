class PagesController < ApplicationController
  def home
    @testimonials = Testimonial.where(approved: true).order(created_at: :desc)
    @gallery_images = Dir.glob("app/assets/images/gallery/*")
                     .sort_by { |img| File.basename(img).split('_').first.to_i } 
                     .map { |img| ActionController::Base.helpers.asset_path(img.gsub("app/assets/images/", "")) }
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

  def leaders
    @board_members = Leader.where(role: "Board").order(:order)
    @team_members = Leader.where(role: "Team").order(:order)
  end

  def media_mentions
    @media_mentions = MediaMention.order(published_date: :desc)
  end
end
