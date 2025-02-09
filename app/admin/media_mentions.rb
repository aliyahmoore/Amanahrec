ActiveAdmin.register MediaMention do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :link, :published_date, :organization_name
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :link, :published_date, :organization_name]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  permit_params :name, :link, :published_date, :organization_name

  index do
    selectable_column
    id_column
    column :name
    column :link
    column :published_date
    column :organization_name
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :name
      row :link
      row :published_date
      row :organization_name
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :link
      f.input :published_date, as: :datepicker
      f.input :organization_name
    end
    f.actions
  end
  
  filter :name
  filter :organization_name
  filter :published_date
  filter :created_at


end
