ActiveAdmin.register Registration do
  actions :index, :show

  index do
    selectable_column
    id_column
    column "User" do |membership|
      "#{membership.user.first_name} #{membership.user.last_name}" # Concatenate first and last names
    end
    column :registrable_type
    column "Registered Item" do |registration|
      if registration.registrable_type == "Trip" && registration.registrable.present?
        registration.registrable.title  # Access the title from Event
      elsif registration.registrable_type == "Activity" && registration.registrable.present?
        registration.registrable.title  # Access the title from Activity
      else
        "No associated Registered Item"
      end
    end
    column :status
    column :number_of_adults
    column :number_of_kids
    column :created_at
    column :updated_at

    actions
  end

  # Customize show page
  show do
    attributes_table do
      row :id
      row :user
      row :registrable_type
      row :registrable_id
      row :status
      row :number_of_adults
      row :number_of_kids
      row :created_at
      row :updated_at
    end
  end
end
