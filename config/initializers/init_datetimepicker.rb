ActiveAdminDatetimepicker::Base.default_datetime_picker_options = {
  format: "m/d/Y h:i A", # JS fordat (12-hour with AM/PM)
  defaultTime: proc { Time.current.strftime("%I:00 %p") } # 12-hour format with AM/PM
}

ActiveAdminDatetimepicker::Base.format = "%m/%d/%Y %I:%M %p" # Ruby format (12-hour with AM/PM)
