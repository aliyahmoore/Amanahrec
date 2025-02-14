ActiveAdmin.register MediaMention do
permit_params :name, :description, :link, :published_date, :organization_name

  index do
    selectable_column
    id_column
    column :name
    column :description do |media_mention|
      truncate(media_mention.description, length: 200)  # Adjust length as needed
    end
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
      row :description
      row :organization_name
      row :published_date
      row :link
      row :image do |activity|
        if activity.image.attached?
          image_tag url_for(activity.image), size: "300x300"
        else
          "No Image"
        end
      end
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :link
      f.input :published_date, as: :datepicker
      f.input :organization_name
    end
    f.inputs "Upload Image" do
      f.input :image, as: :file, hint: f.object.image.attached? ? image_tag(url_for(f.object.image), size: "200x200") : "No image uploaded"
    end
    f.actions
  end

  filter :name
  filter :organization_name
  filter :published_date
  filter :created_at
end
