# Amanah Rec Project

Amanah Rec is a client project developed as part of the final phase of a full-stack bootcamp. The platform empowers the Muslim community by facilitating engagement in activities, events, and community-building initiatives while promoting environmental sustainability and spiritual values. Users can register for activities, manage payments, and track their membership status. The platform also features spaces for testimonials, media mentions, and board member information. The website will be made publicly available.

## Tech Stack
- **Ruby on Rails**: The web framework powering the application.
- **PostgreSQL**: Relational database for storing and managing data.
- **Stripe API**: For processing payments for events, activities, and membership.
- **HTML/CSS/JavaScript**: Front-end technologies for user interface.

### Gems Used
The following Ruby gems were used in this project to enhance functionality:

- **[Devise](https://github.com/heartcombo/devise)** (`~> 4.9`) – Authentication solution for Rails.
- **[htmlbeautifier](https://github.com/threedaymonk/htmlbeautifier)** (`~> 1.4`) – Beautifies HTML output.
- **[Stripe](https://github.com/stripe/stripe-ruby)** (`~> 13.3`) – Integration for Stripe payments.
- **[dotenv-rails](https://github.com/bkeepers/dotenv)** (`~> 2.7`) – Manages environment variables.
- **[simple_calendar](https://github.com/excid3/simple_calendar)** (`~> 3.1`) – Calendar views for events.
- **[friendly_id](https://github.com/norman/friendly_id)** (`~> 5.5`) – For creating human-friendly URLs.
- **[ActiveAdmin](https://github.com/activeadmin/activeadmin)** (`~> 3.2`) – Admin interface for Rails.
- **[faker](https://github.com/faker-ruby/faker)** (`~> 3.5`) – Generates fake data for testing.
- **[Cloudinary](https://github.com/cloudinary/cloudinary_gem)** – Cloud storage for media uploads.
- **[activestorage-cloudinary-service](https://github.com/arkadiyk/activestorage-cloudinary-service)** – Integrates Cloudinary with ActiveStorage 
- **[active_admin_datetimepicker](https://github.com/zpaulovics/active_admin_datetimepicker)** (`~> 1.1`) – Date and time picker frienddly format for ActiveAdmin.


## Features

### Admin Dashboard
The admin dashboard provides a central hub for managing various aspects of the application:
- **User Management**: View user details
- **Activities & Events**: Add and manage activities and events, track capacity and registration status.
- **Payments, Registrations, and Memberships**: View user payments, registrations, and membership statuses.
- **Testimonials**: Approve or reject submitted testimonials.
- **Boards**: Manage board members and display relevant information.
- **Media Mentions**: Manage  media mentions and related details.

### User Profile
- Create an account to register for events, submit testimonials, and manage membership.
- My Registrations page shows all registered events and activities.

### Membership
- Users can sign up for a recurring membership with payments processed through Stripe.
- Membership offers benefits such as early access to events and activities.
- Users can cancel memberships at any time.

### Activity/Event Registration
- Users can register for both free and paid activities/events.
- Registration depends on capacity and, for paid events, requires successful payment.
- Members receive early access to both.
- Payments are processed through Stripe.

### Media Mentions (Latest News)
- The platform displays recent media mentions with links and publication dates.

### Roles
- In addition, two roles were defined: **Admin** and **User** before Active Admin was created that are still in place.  
  - **Admin:** Full access to manage resources through the non-Active Admin dashboard.
  - **User: ** has limited access to register for activities, events, submit testimonials, and manage their own membership.  

## Setup

### Prerequisites
- Ruby (version 3.2.2)
- Rails (version 7.2.2.1)
- PostgreSQL (version 14.13)
- Stripe account for payment processing

### Installation Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/amanahrec.git
   cd amanahrec
   ```

2. Install dependencies:
    ```bash
    bundle install
    ```

3. Set up the database:
    ```bash
    rails db:create
    rails db:migrate
    rails db:seed
    ```

4. Start the server:
    ```bash
    rails server
    ```