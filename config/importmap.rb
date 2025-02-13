# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "testimonial_slider", to: "testimonial_slider.js"
pin "non_member_alert", to: "non_member_alert.js"
pin "navbar_dropdown", to: "navbar_dropdown.js"
pin "recurring_activities", to: "recurring_activities.js"
