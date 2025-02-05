ActiveAdmin.register Payment do

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
  
end
