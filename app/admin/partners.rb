ActiveAdmin.register Partner do
  permit_params :name, :logo

index do
  column :id
  column :name
  column :logo do |partner|
    if partner.logo.attached?
      image_tag url_for(partner.logo), size: "100x100"
    else
      "No Logo Uploaded"
    end
  end
  actions
end

  form do |f|
    f.inputs do
      f.input :name
      f.input :logo, as: :file
    end
    f.actions
end

  show do
    attributes_table do
      row :id
      row :name
      row :logo do |partner|
        if partner.logo.attached?
          image_tag url_for(partner.logo), size: "100x100"
        else
          "No Logo Uploaded"
        end
      end
    end
  end
end
