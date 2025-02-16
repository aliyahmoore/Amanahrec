ActiveAdmin.register User do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :first_name, :last_name, :email, :phone_number, :gender, :age_range, :ethnicity, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at
  #
  # or
  #
  # permit_params do
  #   permitted = [:first_name, :last_name, :email, :phone_number, :gender, :age_range, :ethnicity, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  permit_params :first_name, :last_name, :email, :phone_number, :gender, :age_range,
  :ethnicity, :password, :password_confirmation

  controller do
    def show
      @page_title = "#{resource.first_name} #{resource.last_name}"
    end
  end

  # Customizing the index page
  index do
  selectable_column
  id_column
  column :first_name
  column :last_name
  column :email
  column :phone_number
  column :gender
  column :age_range
  column :ethnicity
  column :created_at
  column :updated_at
  actions
  end

  # Adding filters
  filter :first_name
  filter :last_name
  filter :email
  filter :gender
  filter :age_range
  filter :ethnicity
  filter :created_at

  # Show page customization
  show do
  attributes_table do
  row :id
  row :first_name
  row :last_name
  row :email
  row :phone_number
  row :gender
  row :age_range
  row :ethnicity
  row :created_at
  row :updated_at
  end
  active_admin_comments
  end

  # Form for creating and editing a user
  form do |f|
  f.semantic_errors
  f.inputs "User Details" do
  f.input :first_name
  f.input :last_name
  f.input :email
  f.input :phone_number
  f.input :gender, as: :select, collection: [ [ "Male", "Male" ], [ "Female", "Female" ] ],
            prompt: "Select Gender", input_html: { required: true }
            f.input :age_range, as: :select, collection: [ [ "18-25", "18-25" ], [ "26-35", "26-35" ],
            [ "36-45", "36-45" ], [ "46-55", "46-55" ], [ "56+", "56+" ] ],
prompt: "Select Age Range", input_html: { required: true }
f.input :ethnicity, as: :select, collection: [ [ "White", "White" ], [ "Black or African American", "Black or African American" ],
[ "Asian", "Asian" ], [ "American Indian or Alaska Native", "American Indian or Alaska Native" ],
[ "Native Hawaiian or Other Pacific Islander", "Native Hawaiian or Other Pacific Islander" ],
[ "Hispanic or Latino", "Hispanic or Latino" ], [ "Other", "Other" ],
[ "Prefer not to say", "Prefer not to say" ] ],
prompt: "Select Ethnicity", input_html: { required: true }
  f.input :password
  f.input :password_confirmation
  end
  f.actions
  end
end
