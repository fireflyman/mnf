# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_mnf_session',
  :secret      => '727c63b81c7d6143da26eb1a255227c04289a4d402ad44a1f358c323410821baba8ec77a1cc0d9f42832fc875e1e9b418dd3fd1066324bffe0d9ad08ebfb1cf8'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
