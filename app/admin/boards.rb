ActiveAdmin.register Board do
  permit_params :name, :position, :description, :image

  # Index view customization
  index do
    selectable_column
    id_column
    column :name
    column :position
    column :description
    column :created_at
    column :updated_at
    actions
  end

  # Show view customization
  show do
    attributes_table do
      row :name
      row :position
      row :description
      row :image do |board|
        if board.image.attached?
          image_tag board.image.variant(resize_to_limit: [ 300, 300 ])
        else
          "No image uploaded"
        end
      end
      row :created_at
      row :updated_at
    end
  end

  # Form view customization
  form do |f|
    f.inputs do
      f.input :name
      f.input :position
      f.input :description
      f.input :image, as: :file
    end
    f.actions
  end

   # Filters
   filter :name
   filter :position
end
