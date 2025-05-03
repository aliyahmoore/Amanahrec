ActiveAdmin.register Activity do
  permit_params :title, :description, :start_date, :end_date, :location, :capacity,
                :what_to_bring, :rules, :adult_cost, :kid_cost, :early_access_for_members,
                :early_access_days, :general_registration_start, :user_id, :image

  # Find the slug
  controller do
    def resource
      @activity ||= Activity.friendly.find(params[:id])
    end
  end

  member_action :duplicate, method: :get do
    new_activity = resource.dup

    # Set new start_date and end_date (modify as needed)
    new_activity.start_date = new_activity.start_date + 1.day if new_activity.start_date
    new_activity.end_date = new_activity.end_date + 1.day if new_activity.end_date

    # Save the new activity
    redirect_to new_admin_activity_path(activity: new_activity.attributes)
  end

  # Index Page
  index do
    selectable_column
    id_column
    column :title
    column :start_date do |activity|
      activity.start_date.strftime("%B %d, %Y %I:%M %p") if activity.start_date
    end
    column :end_date do |activity|
      activity.end_date.strftime("%B %d, %Y %I:%M %p") if activity.end_date
    end
    column :location
    column :capacity
    column :adult_cost do |activity|
      number_to_currency(activity.adult_cost, unit: "$", precision: 2)
    end
    column :kid_cost do |activity|
      number_to_currency(activity.kid_cost, unit: "$", precision: 2)
    end
    column :general_registration_start do |activity|
      activity.general_registration_start.strftime("%B %d, %Y %I:%M %p") if activity.general_registration_start
    end
    column :early_access_for_members
    column :early_access_days
    actions do |activity|
      # Add the duplicate link
      link_to "Duplicate", duplicate_admin_activity_path(activity), method: :get
    end
  end

  # Show Page
  show do
    attributes_table do
      row :title
      row :description do |resource|
        simple_format(resource.description)
      end
      row :start_date do |activity|
        activity.start_date.strftime("%B %d, %Y %I:%M %p") if activity.start_date
      end
      row :end_date do |activity|
        activity.end_date.strftime("%B %d, %Y %I:%M %p") if activity.end_date
      end
      row :location
      row :adult_cost do |activity|
        number_to_currency(activity.adult_cost, unit: "$", precision: 2)
      end
      row :kid_cost do |activity|
        number_to_currency(activity.kid_cost, unit: "$", precision: 2)
      end
      row :capacity
      row :general_registration_start do |activity|
        activity.general_registration_start.strftime("%B %d, %Y %I:%M %p") if activity.general_registration_start
      end
      row :early_access_for_members
      row :early_access_days
      row :what_to_bring do |resource|
        simple_format(resource.what_to_bring)
      end
      row :rules do |resource|
        simple_format(resource.rules)
      end
      row :image do |activity|
        if activity.image.attached?
          image_tag url_for(activity.image), size: "300x300"
        else
          "No Image"
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
      para raw("Notes for creating an Activity:<br>
      1. Description uses rich text formatting.<br>
      2. Admin uses 24-hour time, users see 12-hour time.<br>
      3. Date order must be:<br>
      &nbsp;&nbsp;- General Registration Start Date must be before Activity Start Date<br>
      &nbsp;&nbsp;- Start Date must be before End Date. Similarly, End Date cannot be before the Start Date. <br>
      4. If early access for members is enabled, must include the number of days ahead of the General Registration Start Date for early access <br>
      5. Upload an image <br>
      6. Comments are in place of notes")
    end
    f.inputs "Activity Details" do
      f.input :title
      f.input :description, as: :quill_editor
      f.input :start_date, as: :date_time_picker, datepicker_options: { step: 15 }
      f.input :end_date, as: :date_time_picker, datepicker_options: { step: 15 }
      f.input :location
      f.input :capacity
      f.input :adult_cost, input_html: { value: number_with_precision(activity.adult_cost, precision: 2) }
      f.input :kid_cost, input_html: { value: number_with_precision(activity.kid_cost, precision: 2) }
      f.input :what_to_bring, as: :quill_editor
      f.input :rules, as: :quill_editor
      f.input :general_registration_start, as: :date_time_picker, datepicker_options: { step: 15 }
      f.input :early_access_for_members
      f.input :early_access_days
    end

    f.inputs "Upload Image" do
      f.input :image, as: :file, hint: f.object.image.attached? ? image_tag(url_for(f.object.image), size: "200x200") : "No image uploaded"
    end
    f.actions
  end

  # Filters
  filter :title
  filter :start_date
  filter :end_date
  filter :location
  filter :early_access_for_members
  filter :general_registration_start
end
