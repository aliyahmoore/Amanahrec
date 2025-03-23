ActiveAdminDatetimepicker::Base.default_datetime_picker_options = {
  format: 'd/m/Y h:i A', # JS format (12-hour with AM/PM)
  defaultTime: proc { Time.current.strftime('%I:00 %p') } # 12-hour format with AM/PM
}

ActiveAdminDatetimepicker::Base.format = "%d/%m/%Y %I:%M %p" # Ruby format (12-hour with AM/PM)