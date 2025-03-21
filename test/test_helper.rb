ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :roles, :users, :memberships, :trips, :activities, :media_mentions, :leaders
    # Add more helper methods to be used by all tests here...

    setup do
      puts "Users in database: #{User.pluck(:id)}"
      puts "Memberships in database: #{Membership.pluck(:user_id)}"
    end
  end
end
