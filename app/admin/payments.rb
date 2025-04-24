ActiveAdmin.register Payment do
  actions :index, :show

  index do
    div class: "admin-instructions" do
      para "This section displays a summary of all membership and activity/event/trip payments. Payments are view-only and cannot be modified from the admin panel."
    end
    selectable_column
    id_column
    column "User" do |membership|
      "#{membership.user.first_name} #{membership.user.last_name}" # Concatenate first and last names
    end
    column :amount, sortable: true do |payment|
      number_to_currency(payment.amount)
    end
    column :status
    column :is_recurring
    column :recurring_type
    column :paymentable_type
    column "Payment Item" do |payment|
      if payment.paymentable.present?
        case payment.paymentable_type
        when "Trip", "Activity"
          payment.paymentable.title
        when "Membership"
          "Membership Payment"  # Memberships don't have a title, so use a generic label
        else
          "No associated Payment Item"
        end
      else
        "No associated Payment Item"
      end
    end
    column :created_at
    column :updated_at
  end

  show do
    attributes_table do
      row :user
      row :stripe_payment_id
      row :amount do |payment|
        number_to_currency(payment.amount)
      end
      row :status
      row :is_recurring
      row :recurring_type
      row :paymentable_type
      row  "Payment Category" do |payment|
        if payment.paymentable_type == "Trip" && payment.paymentable.present?
          payment.paymentable.title  # Access the title from Trip
        elsif payment.paymentable_type == "Activity" && payment.paymentable.present?
          payment.paymentable.title  # Access the title from Activity
        else
          "No associated Payment Category"
        end
      end
      row :created_at
      row :updated_at
    end
  end

  filter :user
  filter :status
  filter :is_recurring
  filter :recurring_type
  filter :amount
  filter :created_at
end
