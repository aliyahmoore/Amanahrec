ActiveAdmin.register About do
  permit_params :mission, :vision, :founder, :image

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
