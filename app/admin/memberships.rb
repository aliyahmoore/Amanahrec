ActiveAdmin.register Membership do
  actions :index, :show

  index do
    div class: "admin-instructions" do
      para "This section displays a summary of all user memberships. Memberships are view-only and cannot be created or edited from the admin panel."
    end
    selectable_column
    id_column
    column "User" do |membership|
      "#{membership.user.first_name} #{membership.user.last_name}" # Concatenate first and last names
    end
    column :start_date
    column :end_date
    column :status
    column :stripe_customer_id
    column :stripe_subscription_id
    column :created_at
    column :updated_at
  end

  show do
    attributes_table do
      row :user
      row :start_date
      row :end_date
      row :status
      row :stripe_customer_id
      row :stripe_subscription_id
      row :created_at
      row :updated_at
    end
  end

  filter :user
  filter :status
  filter :start_date
  filter :end_date
end
