require 'sidekiq/scheduler'
Sidekiq.schedule = YAML.load_file(File.expand_path("../../../config/scheduler.yml",__FILE__))
