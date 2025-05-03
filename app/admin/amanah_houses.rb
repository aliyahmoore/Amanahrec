ActiveAdmin.register AmanahHouse do
  permit_params :location, :description, :image

  index do
    selectable_column
    id_column
    column :location
    column :description
    actions
  end

  form do |f|
    f.inputs "Amanah House Details" do
      f.input :location
      f.input :description
      f.inputs "Upload Image" do
        f.input :image, as: :file, hint: f.object.image.attached? ? image_tag(url_for(f.object.image), size: "200x200") : "No image uploaded"
      end
    end

    f.actions
  end

  show do
    attributes_table do
      row :location
      row :description
      row :image do |amanah_house|
        if amanah_house.image.attached?
          image_tag url_for(amanah_house.image), size: "300x300"
        else
          "No Image"
        end
      end
    end
  end
end
