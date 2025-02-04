module Findable
    extend ActiveSupport::Concern

    included do
      before_action :set_paymentable, only: [ :create, :success ]
    end
  
    private

    def set_paymentable
      @paymentable = find_paymentable(params[:paymentable_type], params[:paymentable_id])
      redirect_to root_url, alert: "Unable to find the requested item." unless @paymentable
    end

    def find_paymentable(type, id)
        if type == "Membership"
          Membership.find_by(user: current_user) || Membership.create!(user: current_user, status: "pending")
        elsif %w[Activity Event].include?(type)
          type.constantize.find_by(id: id)
        else
          nil
        end
      rescue ActiveRecord::RecordNotFound
        redirect_to root_url, alert: t("errors.payment.invalid_paymentable")
      end
end
