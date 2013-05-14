# encoding: utf-8

module PagesSchedule
  class Plugin < PagesCore::Plugin
    def admin_menu_tabs
      [
        :label => PagesSchedule.config(:module_name),
        :url   => {:controller => 'admin/schedule_events', :action => 'index'}
      ]
    end
  end
end
