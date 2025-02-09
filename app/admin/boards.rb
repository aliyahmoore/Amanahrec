ActiveAdmin.register Board do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :position, :description
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :position, :description]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
  permit_params :name, :position, :description, :image

  # Show view customization
  show do
    attributes_table do
      row :name
      row :position
      row :description
      row :image do |board|
        if board.image.attached?
          image_tag board.image.variant(resize_to_limit: [300, 300])
        else
          "No image uploaded"
        end
      end
      row :created_at
      row :updated_at
    end
  end

  # Filters
  filter :name
  filter :position
  filter :created_at

  # Index view customization
  index do
    selectable_column
    id_column
    column :name
    column :position
    column :description
    column :created_at
    actions
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
end
