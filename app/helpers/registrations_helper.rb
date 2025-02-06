module RegistrationsHelper
    def formatted_start_date(registrable)
      registrable.start_date.strftime("%B %d, %Y") if registrable&.start_date.present?
    end
end