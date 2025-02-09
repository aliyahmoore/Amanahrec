ActiveAdmin.register MediaMention do
permit_params :name, :link, :published_date, :organization_name

  index do
    selectable_column
    id_column
    column :name
    column :organization_name
    column :published_date
    column :link
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :name
      row :organization_name
      row :published_date
      row :link
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
