require_relative '../lib/database_connection'

def sign_up_as_test_user
  visit '/'
  fill_in :name, with: 'Stan Testson'
  fill_in :email, with: 'stan@stan.com'
  fill_in :password, with: 'password123'
  click_button :Submit
end

def insert_users_into_test_database
  User.create(name: 'Stan Testson', email: 'stan@stan.com', \
              password: 'password123')
  User.create(name: 'Alice Bobson', email: 'albobson@gmail.com', \
              password: 'password321')
end

def log_in
  visit '/'
  click_button 'Log in'
  fill_in :email, with: 'stan@stan.com'
  fill_in :password, with: 'password123'
  click_button 'Submit'
end

def insert_posting_into_test_database
  Posting.create('My first posting', 'Description', '100', '1', '06/11/2018', '07/11/2018')
end

def insert_booking_into_test_database
  insert_users_into_test_database
  insert_posting_into_test_database
  DatabaseConnection.query("INSERT INTO bookings(posting_id,owner_id,user_id,booking_date) \
  VALUES('1','1','2','2018-11-08');")
end

def create_new_posting
  sign_up_as_test_user
  visit '/postings/new'
  fill_in :title, with: 'Cool new place!'
  fill_in :description, with: 'You will love it!'
  fill_in :price, with: 5
  click_button 'Submit'
end

def log_in_as_second_user
  visit('/')
  click_button 'Log in'
  fill_in :email, with: 'albobson@gmail.com'
  fill_in :password, with: 'password321'
  click_button 'Submit'
end

def request_booking_as_second_user
  insert_users_into_test_database
  insert_posting_into_test_database
  log_in_as_second_user
  click_button 'View Listings'
  click_button 'Book'
  # save_and_open_page
  click_button 'Submit Booking'
  # save_and_open_page
end

def log_in_as_two_users_accept_booking
  request_booking_as_second_user
  click_button 'Home'
  click_button 'Log out'
  log_in
  click_button 'Your received bookings'
  click_button 'Accept'
  first(:button, 'Home').click
  click_button 'Log out'
end
