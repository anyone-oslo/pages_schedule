class CreateScheduleEvents < ActiveRecord::Migration
	def self.up
		create_table :schedule_events do |t|
			t.string     :name, :location, :link
			t.belongs_to :image
			t.datetime   :starts_at, :ends_at
			t.boolean    :published, :null => false, :default => false
			t.timestamps
		end
	end

	def self.down
		drop_table :schedule_events
	end
end
