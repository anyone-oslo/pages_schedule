class ScheduleEvent < ActiveRecord::Base
	belongs_to_image :image
	validates_presence_of :name, :starts_at, :ends_at
	
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
	end
	
	def year
		self.starts_at.year
	end

	def upcoming?
		(Time.now < self.starts_at) ? true : false
	end
	
	def past?
		(self.upcoming?) ? false : true
	end
	
	def today?
		(self.starts_at.to_date == Date.today) ? true : false
	end

end
