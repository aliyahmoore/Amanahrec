ActiveAdmin.register Leader do
  permit_params :name, :position, :description, :image, :role, :order

  # Index view customization
  index do
    selectable_column
    id_column
    column :name
    column :position
    column :description
    column :role
    column :order
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
      row :role
      row :order
      row :image do |leader|
        if leader.image.attached?
          image_tag leader.image.variant(resize_to_limit: [ 300, 300 ])
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
      f.input :role, as: :select, collection: [ "Board", "Team" ], prompt: "Select Role Type"
      f.input :order
      f.input :image, as: :file
    end
    f.actions
  end

   # Filters
   filter :name
   filter :position
end
