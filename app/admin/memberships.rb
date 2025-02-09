ActiveAdmin.register Membership do

  actions :index, :show
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :user_id, :start_date, :end_date, :status, :stripe_customer_id, :stripe_subscription_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:user_id, :start_date, :end_date, :status, :stripe_customer_id, :stripe_subscription_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  
  index do
    selectable_column
    id_column
    column :user
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
