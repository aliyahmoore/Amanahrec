ActiveAdmin.register Testimonial do
  # Custom actions for approving and unapproving testimonials
  member_action :approve, method: :put do
    resource.update(approved: true)
    redirect_to resource_path, notice: "Testimonial approved successfully."
  end

  member_action :unapprove, method: :put do
    resource.update(approved: false)
    redirect_to resource_path, notice: "Testimonial unapproved successfully."
  end

  # Index view customization
  index do
    selectable_column
    id_column
    column "User" do |testimonial|
      "#{testimonial.user.first_name} #{testimonial.user.last_name}" if testimonial.user
    end
    column :text do |testimonial|
      truncate(testimonial.text, length: 100)
    end
    column :approved
    column :created_at
    column :updated_at
    actions defaults: true do |testimonial|
      if testimonial.approved
        link_to "Unapprove", unapprove_admin_testimonial_path(testimonial), method: :put
      else
        link_to "Approve", approve_admin_testimonial_path(testimonial), method: :put
      end
    end
  end

  # Show view customization
  show do
    attributes_table do
      row "User" do |testimonial|
        "#{testimonial.user.first_name} #{testimonial.user.last_name}" if testimonial.user
      end
      row :text
      row :approved
      row :created_at
      row :updated_at
    end
  end

  # Form view customization
  form do |f|
    f.inputs do
      f.input :user, collection: User.all, prompt: "Select a User"
      f.input :text
      f.input :approved
    end
    f.actions
  end
end
