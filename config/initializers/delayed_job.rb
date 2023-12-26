Delayed::Backend::ActiveRecord.configuration.reserve_sql_strategy = :default_sql
Delayed::Worker.logger = Logger.new(File.join(Rails.root, 'log', 'delayed_job.log'))
