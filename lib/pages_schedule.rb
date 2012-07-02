require 'pages_schedule/plugin'

module PagesSchedule
	def self.config(key, value=nil)
		key = key.to_s
		@@config ||= {}
		@@config[key] = value if value != nil
		@@config[key]
	end

	# Default options
	config :module_name, "Schedule"
	config :use_image,   false
	config :use_ends_at, false
end
