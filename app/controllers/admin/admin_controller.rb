class Admin::AdminController < ApplicationController

	# Adds menu items for the pages_schedule plugin
	def pages_schedule_menu_items
		register_menu_item PagesSchedule.config(:module_name), hash_for_admin_schedule_events_path, :pages_plugins
	end
	protected     :pages_schedule_menu_items
	before_filter :pages_schedule_menu_items
	
end
