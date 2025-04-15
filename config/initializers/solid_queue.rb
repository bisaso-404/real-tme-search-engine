# Force SolidQueue to use the primary database connection
Rails.application.config.to_prepare do
  SolidQueue::Record.connects_to database: { writing: :primary, reading: :primary }
end