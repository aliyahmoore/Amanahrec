class EmailValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      unless value =~ URI::MailTo::EMAIL_REGEXP
        record.errors.add(attribute, "is not a valid email address")
      end
    end
end
