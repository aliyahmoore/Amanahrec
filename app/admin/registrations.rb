ActiveAdmin.register Registration do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :user_id, :registrable_type, :registrable_id, :status
  #
  # or
  #
  # permit_params do
  #   permitted = [:user_id, :registrable_type, :registrable_id, :status]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  actions :index, :show

  index do
    selectable_column
    id_column
    column :user
    column :registrable_type
    column :registrable_id
    column :status
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
      row :created_at
      row :updated_at
    end
  end

end
