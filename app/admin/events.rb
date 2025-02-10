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
    column :start_date do |event|
      event.start_date.strftime("%B %d, %Y %I:%M %p") if event.start_date
    end
    column :end_date do |event|
      event.end_date.strftime("%B %d, %Y %I:%M %p") if event.end_date
    end
    column :location
    column :cost do |event|
      number_to_currency(event.cost, unit: "$", precision: 2)
    end
    column :capacity
    column :general_registration_start do |event|
      event.general_registration_start.strftime("%B %d, %Y %I:%M %p") if event.general_registration_start
    end
    column :rsvp_deadline do |event|
      event.rsvp_deadline.strftime("%B %d, %Y %I:%M %p") if event.rsvp_deadline
    end
    column :early_access_for_members
    column :early_access_days
    actions
  end

  # Show
  show do
    attributes_table do
      row :title
      row :description
      row :start_date do |event|
        event.start_date.strftime("%B %d, %Y %I:%M %p") if event.start_date
      end
      row :end_date do |event|
        event.end_date.strftime("%B %d, %Y %I:%M %p") if event.end_date
      end
      row :location
      row :cost do |event|
        number_to_currency(event.cost, unit: "$", precision: 2)
      end
      row :capacity
      row :general_registration_start do |event|
        event.general_registration_start.strftime("%B %d, %Y %I:%M %p") if event.general_registration_start
      end
      row :rsvp_deadline do |event|
        event.rsvp_deadline.strftime("%B %d, %Y %I:%M %p") if event.rsvp_deadline
      end
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

  # Form
  form do |f|
    f.inputs "Event Details" do
      f.input :title
      f.input :description
      f.input :start_date, as: :datepicker
      f.input :end_date, as: :datepicker
      f.input :location
      f.input :capacity
      f.input :cost
      f.input :childcare
      f.input :sponsors
      f.input :general_registration_start, as: :datepicker
      f.input :rsvp_deadline, as: :datepicker
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
