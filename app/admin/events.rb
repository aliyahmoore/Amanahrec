ActiveAdmin.register Event do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :title, :description, :start_date, :end_date, :location, :rsvp_deadline, :childcare, :sponsors, :cost, :early_access_for_members, :early_access_days, :general_registration_start, :capacity
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :description, :start_date, :end_date, :location, :rsvp_deadline, :childcare, :sponsors, :cost, :early_access_for_members, :early_access_days, :general_registration_start, :capacity]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  controller do
    def resource
      @event ||= Event.friendly.find(params[:id])
    end
  end 
  # Index page customization
  index do
    selectable_column
    id_column
    column :title
    column :start_date
    column :end_date
    column :location
    column :capacity
    column :cost
    column :general_registration_start
    column :early_access_for_members
    actions
  end

  # Filters for the index page
  filter :title
  filter :start_date
  filter :end_date
  filter :location
  filter :capacity
  filter :rsvp_deadline
  filter :childcare
  filter :cost
  filter :early_access_for_members
  filter :general_registration_start

  # Permit Parameters
  permit_params :title, :description, :start_date, :end_date, :location, :capacity, 
                :rsvp_deadline, :childcare, :sponsors, :cost, :early_access_for_members, 
                :early_access_days, :general_registration_start, :user_id, :images
  
end
