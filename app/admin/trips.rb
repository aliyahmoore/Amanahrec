ActiveAdmin.register Trip do
  permit_params :title, :description, :start_date, :end_date, :location, :capacity,
                :rsvp_deadline, :childcare, :sponsors, :adult_cost, :kid_cost, :early_access_for_members,
                :early_access_days, :general_registration_start, :user_id, images: []

  # Find the slug
  controller do
    def resource
      @trip ||= Trip.friendly.find(params[:id])
    end
  end

  member_action :duplicate, method: :get do
    new_trip = resource.dup

    # Set new start_date and end_date (modify as needed)
    new_trip.start_date = new_trip.start_date + 1.day if new_trip.start_date
    new_trip.end_date = new_trip.end_date + 1.day if new_trip.end_date

    # Save the new trip
    redirect_to new_admin_trip_path(trip: new_trip.attributes)
  end

  # Index
  index do
    selectable_column
    id_column
    column :title
    column :start_date do |trip|
      trip.start_date.strftime("%B %d, %Y %I:%M %p") if trip.start_date
    end
    column :end_date do |trip|
      trip.end_date.strftime("%B %d, %Y %I:%M %p") if trip.end_date
    end
    column :location
    column :adult_cost do |trip|
      number_to_currency(trip.adult_cost, unit: "$", precision: 2)
    end
    column :kid_cost do |trip|
      number_to_currency(trip.kid_cost, unit: "$", precision: 2)
    end
    column :capacity
    column :general_registration_start do |trip|
      trip.general_registration_start.strftime("%B %d, %Y %I:%M %p") if trip.general_registration_start
    end
    column :rsvp_deadline do |trip|
      trip.rsvp_deadline.strftime("%B %d, %Y %I:%M %p") if trip.rsvp_deadline
    end
    column :early_access_for_members
    column :early_access_days
    actions do |trip|
      # Add the duplicate link
      link_to "Duplicate", duplicate_admin_trip_path(trip), method: :get
    end
  end

  # Show
  show do
    attributes_table do
      row :title
      row :description do |resource|
        simple_format(resource.description)
      end
      row :start_date do |trip|
        trip.start_date.strftime("%B %d, %Y %I:%M %p") if trip.start_date
      end
      row :end_date do |trip|
        trip.end_date.strftime("%B %d, %Y %I:%M %p") if trip.end_date
      end
      row :location
      row :adult_cost do |trip|
        number_to_currency(trip.adult_cost, unit: "$", precision: 2)
      end
      row :kid_cost do |trip|
        number_to_currency(trip.kid_cost, unit: "$", precision: 2)
      end
      row :capacity
      row :general_registration_start do |trip|
        trip.general_registration_start.strftime("%B %d, %Y %I:%M %p") if trip.general_registration_start
      end
      row :rsvp_deadline do |trip|
        trip.rsvp_deadline.strftime("%B %d, %Y %I:%M %p") if trip.rsvp_deadline
      end
      row :early_access_for_members
      row :early_access_days
      row :childcare
      row :sponsors
      row :images do |trip|
        if trip.images.attached?
          div class: "trip-images" do
            trip.images.each do |img|
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
    div class: "admin-instructions" do
      para raw("Notes for creating a Trip:<br>
      1. Description uses rich text formatting.<br>
      2. Admin uses 24-hour time, users see 12-hour time.<br>
      3. Date order must be:<br>
      &nbsp;&nbsp;- General Registration Start Date must be before Activity Start Date<br>
      &nbsp;&nbsp;- Start Date must be before End Date. Similarly, End Date cannot be before the Start Date. <br>
      4. If early access for members is enabled, must include the number of days ahead of the General Registration Start Date for early access <br>
      5. Upload an image")
    end
    f.inputs "Trip Details" do
      f.input :title
      f.input :description, as: :quill_editor
      f.input :start_date, as: :date_time_picker, datepicker_options: { step: 15 }
      f.input :end_date, as: :date_time_picker, datepicker_options: { step: 15 }
      f.input :location
      f.input :capacity
      f.input :adult_cost, input_html: { value: number_with_precision(trip.adult_cost, precision: 2) }
      f.input :kid_cost, input_html: { value: number_with_precision(trip.kid_cost, precision: 2) }
      f.input :childcare
      f.input :sponsors
      f.input :general_registration_start, as: :date_time_picker, datepicker_options: { step: 15 }
      f.input :rsvp_deadline, as: :date_time_picker, datepicker_options: { step: 15 }
      f.input :early_access_for_members
      f.input :early_access_days
    end

    f.inputs "Upload Images" do
      f.input :images, as: :file, input_html: { multiple: true }

      if f.object.images.attached?
        f.object.images.each do |img|
          div do
            begin
              image_tag url_for(img), size: "100x100", style: "margin: 5px;"
            rescue => e
              para "Image preview failed: #{e.message}"
            end
          end
        end
      else
        para "No images uploaded"
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
