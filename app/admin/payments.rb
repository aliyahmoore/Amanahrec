ActiveAdmin.register Payment do
  actions :index, :show

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :stripe_payment_id, :amount, :status, :user_id, :is_recurring, :recurring_type, :paymentable_type, :paymentable_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:stripe_payment_id, :amount, :status, :user_id, :is_recurring, :recurring_type, :paymentable_type, :paymentable_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    selectable_column
    id_column
    column "User" do |membership|
      "#{membership.user.first_name} #{membership.user.last_name}" # Concatenate first and last names
    end
    column :stripe_payment_id
    column :amount, sortable: true do |payment|
      number_to_currency(payment.amount)
    end
    column :status
    column :is_recurring
    column :recurring_type
    column :paymentable_type
    column :paymentable_id
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
      row :paymentable_id
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
