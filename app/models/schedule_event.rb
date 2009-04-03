class ScheduleEvent < ActiveRecord::Base
	belongs_to_image :image
	validates_presence_of :name, :starts_at, :ends_at
	
	validate do |schedule_event|
		if !schedule_event.ends_at || schedule_event.ends_at < schedule_event.starts_at
			schedule_event.ends_at = schedule_event.starts_at
		end
	end
	
	class << self
		def years
			self.find_by_sql('SELECT DISTINCT YEAR(starts_at) AS `starts_at_year` FROM `schedule_events` ORDER BY `starts_at_year` ASC').map{|se| se.starts_at_year}.sort.mapped.to_i
		end
		
		def find_by_year(year, options={})
			find_options = {
				:conditions => ['YEAR(starts_at) = ?', year],
				:order      => 'starts_at DESC'
			}.merge(options)
			self.find(:all, find_options)
		end
		
		# Find upcoming events
		def find_upcoming(options={})
			find_options = {
				:conditions => ['published = 1 AND ends_at >= ?', Time.now],
				:order      => 'starts_at ASC'
			}.merge(options)

			if find_options.has_key?(:within)
				find_options[:conditions].first += " AND ends_at <= ?"
				find_options[:conditions] << (Time.now + find_options[:within])
				find_options.delete(:within)
			end
			
			self.find(:all, find_options)
		end
	end
	
	def year
		self.starts_at.year
	end

	def upcoming?
		(Time.now < self.ends_at) ? true : false
	end
	
	def past?
		(self.upcoming?) ? false : true
	end
	
	def today?
		(self.starts_at.to_date == Date.today) ? true : false
	end
	
	def duration
		self.ends_at - self.starts_at
	end

	# Does this event have a duration?
	def duration?(options={})
		options[:fuzziness] ||= 60.seconds
		(self.duration > options[:fuzziness]) ? true : false
	end
	
	def multiple_days?
		(self.ends_at.beginning_of_day > self.starts_at.beginning_of_day) ? true : false
	end
	
	def link
		url = self[:link]
		url = "http://#{url}" unless url =~ /^https?:\/\//
		url
	end

end
