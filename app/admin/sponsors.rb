ActiveAdmin.register Sponsor do
  permit_params :name, :logo, :link

index do
  column :id
  column :name
  column :link
  column :logo do |sponsor|
    if sponsor.logo.attached?
      image_tag url_for(sponsor.logo), size: "100x100"
    else
      "No Logo Uploaded"
    end
  end
  actions
end

  form do |f|
    f.inputs do
      f.input :name
      f.input :link
      f.input :logo, as: :file
    end
    f.actions
end

  show do
    attributes_table do
      row :id
      row :name
      row :link
      row :logo do |sponsor|
        if sponsor.logo.attached?
          image_tag url_for(sponsor.logo), size: "100x100"
        else
          "No Logo Uploaded"
        end
      end
    end
  end
end
