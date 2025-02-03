module Findable
    extend ActiveSupport::Concern
  
    included do
      before_action :set_paymentable, only: [:create, :success]
    end
  
    private
  
    def set_paymentable
      @paymentable = find_paymentable(params[:paymentable_type], params[:paymentable_id])
      redirect_to root_url, alert: "Unable to find the requested item." unless @paymentable
    end
  
    def find_paymentable(type, id)
      type.constantize.find_by(id: id) if %w[Activity Event Membership].include?(type)
    rescue NameError
      nil
    end
  end