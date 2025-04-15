# Load the Rails application.
require_relative "application"

puts "DEBUG: SECRET_KEY_BASE length = #{ENV['151ac3875a09cfb9abb9f4121ff49084717f0e11973ffec376a8accbee02fcdf4ca60104f923801a0d4314924024bfac33daaab7b8b2123127ee440d9d18a518']&.length || 'not set'}"

# Initialize the Rails application.
Rails.application.initialize!
