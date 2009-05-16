# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_ruby-mentors_session',
  :secret      => 'e7768d246c682bcdade202ad21085a949a7684ae6367332eb90d3133c15f400f9fce8ed6014f7243c324ab18ab1feda88f3133a60d2edeca2326ddb909dd285e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
