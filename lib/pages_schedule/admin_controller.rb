module PagesSchedule
  module AdminController
    def self.included(base)
      base.before_filter :pages_schedule_menu_items
    end

    protected
      def pages_schedule_menu_items
        register_menu_item PagesSchedule.config(:module_name), hash_for_admin_schedule_events_path, :pages_plugins
      end
  end
end

PagesCore::AdminController.send :include, PagesSchedule::AdminController