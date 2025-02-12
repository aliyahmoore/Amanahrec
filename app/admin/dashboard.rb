# frozen_string_literal: true

ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    # Section for Events and Activities
    section "Events and Activities" do
      columns do
        column do
          panel "Upcoming Events" do
            table_for Event.order(start_date: :desc).limit(5) do
              column("Event Title") { |event| link_to event.title, admin_event_path(event) }
              column("Registrations") { |event| event.registrations.count }
              column("Capacity") { |event| event.capacity }
            end
          end
        end

        column do
          panel "Upcoming Activities" do
            table_for Activity.order(created_at: :desc).limit(5) do
              column("Activity Title") { |activity| link_to activity.title, admin_activity_path(activity) }
              column("Registrations") { |activity| activity.registrations.count }
              column("Capacity") { |activity| activity.capacity }
            end
          end
        end
      end
    end

    # Section for Boards and Media Mentions on the Same Row
section "Testimonials and Media Mentions" do
  columns do
    column do
      panel "Pending Testimonials" do
        table_for Testimonial.where(approved: false).limit(5) do
          column("Testimonial") { |testimonial| link_to testimonial.text.truncate(50), admin_testimonial_path(testimonial) }
          column("Submitted By") { |testimonial| link_to "#{testimonial.user.first_name} #{testimonial.user.last_name}", admin_user_path(testimonial.user) }
          column("Submitted Date") { |testimonial| testimonial.created_at.strftime('%B %d, %Y') }
        end
      end
    end


    column do
      panel "Recent Media Mentions" do
        table_for MediaMention.order(published_date: :desc).limit(5) do
          column("Title") { |mention| link_to mention.name, admin_media_mention_path(mention) }
          column("Published Date") { |mention| mention.published_date.strftime('%B %d, %Y') }
        end
      end
    end
  end
end


    # Section for Membership, Payments, and Registrations
    section "Memberships and Payments" do
      columns do
        column do
          panel "Active Memberships", :class => "membership-section" do
            div do
              Membership.where(status: 'active').count
            end
          end
        end

        column do
          panel "Recent Payments", :class => "payments-section" do
            table_for Payment.order(created_at: :desc).limit(5) do
              column("User") { |payment|  "#{payment.user.first_name} #{payment.user.last_name}" }
              column("Amount") { |payment| payment.amount }
              column("Status") { |payment| payment.status }
              column("View") { |payment| link_to('View', admin_payment_path(payment)) }
            end
          end
        end

       
      end
    end

    # Section for User Statistics (Gender, Age Range, Ethnicity)
    section "User Statistics" do
      columns do
        column do
          panel "Gender Distribution" do
            gender_counts = User.group(:gender).count.to_a
            total_count = gender_counts.sum { |_, count| count }
          
            table_for gender_counts do
              column("Gender") { |row| row[0] }
              column("Count") { |row| row[1] }
            end
          
            div style: "font-weight: bold; margin-top: 10px;" do
              "Total: #{total_count}"
            end
          end
        end

        column do
          panel "Age Range" do
            age_ranges = ["18-25", "26-35", "36-45", "46-55", "56+"]
            table_for age_ranges.map { |range| [range, User.where(age_range: range).count] } do
              column("Age Range") { |row| row[0] }
              column("Count") { |row| row[1] }
            end
          end
        end

        column do
          panel "Ethnicity Breakdown" do
            ethnicities = ["American Indian or Alaska Native", "Asian", "Black or African American", "Hispanic or Latino", 
                       "Native Hawaiian or Other Pacific Islander", "Other", "Prefer not to say", "White"]
        table_for ethnicities.map { |eth| [eth, User.where(ethnicity: eth).count] } do
              column("Ethnicity") { |row| row[0] }
              column("Count") { |row| row[1] }
            end
          end
        end
      end
    end
  end
end