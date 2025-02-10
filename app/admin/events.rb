ActiveAdmin.register Event do
  permit_params :title, :description, :start_date, :end_date, :location, :capacity,
                :rsvp_deadline, :childcare, :sponsors, :cost, :early_access_for_members,
                :early_access_days, :general_registration_start, :user_id, images: []

  # Find the slug
  controller do
    def resource
      @event ||= Event.friendly.find(params[:id])
    end
  end

  # Index
  index do
    selectable_column
    id_column
    column :title
    column :start_date
    column :end_date
    column :location
    column :cost
    column :capacity
    column :general_registration_start
    column :early_access_for_members
    column :early_access_days
    actions
  end

  # Show
  show do
    attributes_table do
      row :title
      row :description
      row :start_date
      row :end_date
      row :location
      row :cost do |activity|
        number_to_currency(activity.cost, unit: "$", precision: 2) # Formats cost with two decimal places
      end
      row :capacity
      row :general_registration_start
      row :rsvp_deadline
      row :early_access_for_members
      row :early_access_days
      row :childcare
      row :sponsors
      row :images do |event|
        if event.images.attached?
          div class: "event-images" do
            event.images.each do |img|
              span do
                image_tag url_for(img), size: "200x200", style: "margin: 5px;"
              end
            end
          end
        else
          "No Images"
        end
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  form do |f|
    f.inputs "Activity Details" do
      f.input :title
      f.input :description
      f.input :start_date, as: :datepicker
      f.input :end_date, as: :datepicker
      f.input :location
      f.input :capacity
      f.input :cost do |activity|
        number_to_currency(activity.cost, unit: "$", precision: 2) # Formats cost with two decimal places
      end
      f.input :childcare
      f.input :sponsors
      f.input :general_registration_start, as: :datepicker
      f.input :rsvp_deadline
      f.input :early_access_for_members
      f.input :early_access_days
    end

    f.inputs "Upload Images" do
      f.input :images, as: :file, input_html: { multiple: true }
      if f.object.images.attached?
        f.object.images.each do |img|
          div do
            image_tag url_for(img), size: "100x100", style: "margin: 5px;"
          end
        end
      end
    end

    f.actions
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
end
