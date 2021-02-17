-----------TESTING-------------

Manual testing: change code, reload and check the output.
Important but not efficient for large projects.

in Keroku logs look for "FATAL"

rollback to previous version on Heroku: heroku rollback
also rollback migrations: heroku run rails db:rollback


>>> minitest:

Gemfile:

group :test do
    # Adds support for Capybara system testing and selenium driver
    gem 'capybara', '>= 2.15'
    gem 'selenium-webdriver'
    # Easy installation and use of web drivers to run system tests with browsers
    gem 'webdrivers'
    gem 'launchy'
  end



  >>> test_helper.rb

  ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase

  parallelize(workers: :number_of_processors)

  fixtures :all
  include Warden::Test::Helpers
  Warden.test_mode!
end

Capybara.register_driver :headless_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new(args: %w[no-sandbox headless disable-gpu window-size=1400,900])
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end
Capybara.save_path = Rails.root.join("tmp/capybara")
Capybara.javascript_driver = :headless_chrome


>>> Warden: can fake logins
>>> Capybara: headless chrome


>>> application_system_test_Case.rv

change to headless chrome

require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  # driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
  driven_by :headless_chrome # Update this line
end

test.rb
change to  config.action_dispatch.show_exceptions = true 


----
make sure you use the right test file in the right folder!!!
---


Test principle in 4 steps:

class TestSomeObject
    test "something on object do"
    # setup
    # exercise
    # verify --> is this what I expected?
    # teardown --> 
    end
end



generate tests for model:

rails g system_test product


add products only to test database by adding y yml file in 
test/fixtures/prodcuts.yml

skello:
  name: "Skello"
  tagline: "Manage your staff calendar"
roadstr:
  name: "Roadstr"
  tagline: "Rent a vintage car"


---CHEATSHEET---
https://devhints.io/capybara


You can put erb inside your fixtures!

# products.yml
<% 1.upto(5) do |i| %>
product_<%= i %>:
  name: <%= Faker::Company.name %>
  tagline: <%= Faker::Company.catch_phrase %>
<% end %>



UNIT TESTING: more about the models