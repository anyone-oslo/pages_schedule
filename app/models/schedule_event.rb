# encoding: utf-8

class ScheduleEvent < ActiveRecord::Base
  include PagesCore::Sweepable

  belongs_to_image :image, optional: true
  validates_presence_of :name, :starts_at

  scope :sorted, -> { order('starts_at DESC') }
  scope :published, -> { where(published: true) }

  validate do |schedule_event|
    if !PagesSchedule.config(:use_ends_at) ||
      (!schedule_event.ends_at || schedule_event.ends_at < schedule_event.starts_at)
      schedule_event.ends_at = schedule_event.starts_at
    end
  end

  class << self
    def years
      query = if mysql?
                "SELECT DISTINCT YEAR(starts_at) AS `starts_at_year` " \
                "FROM `schedule_events`"
              else
                "SELECT DISTINCT EXTRACT(year FROM starts_at) AS " \
                "starts_at_year FROM schedule_events"
              end
      find_by_sql(query).map(&:starts_at_year).sort.map(&:to_i)
    end

    def by_year(year)
      where('starts_at >= ? AND starts_at <=?',
            DateTime.new(year.to_i).beginning_of_year,
            DateTime.new(year.to_i).end_of_year)
    end

    # Find upcoming events
    def upcoming
      where('ends_at >= ?', Time.now)
    end

    def mysql?
      ActiveRecord::Base.connection.adapter_name.downcase.starts_with?("mysql")
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
