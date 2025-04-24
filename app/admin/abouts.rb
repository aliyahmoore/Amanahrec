ActiveAdmin.register About do
  permit_params :mission, :vision, :founder, :image

  index do
    div class: "admin-instructions" do
      para "The Abouts page displays the organization's mission, vision, and founder, along with the founder's image. Click view for more details or edit the entry as needed — typically, only one record is required"
    end

    selectable_column
    id_column
    column :mission
    column :vision
    column :founder
    actions
  end

  form do |f|
    f.inputs "About Details" do
      f.input :mission
      f.input :vision
      f.input :founder
      f.input :image, as: :file
    end
    f.actions
  end

  show do
    attributes_table do
      row :mission
      row :vision
      row :founder
      row :image do |about|
        if about.image.attached?
          image_tag url_for(about.image), size: "200x200"
        else
          "No image uploaded"
        end
      end
    end
  end
end
