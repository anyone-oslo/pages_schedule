# encoding: utf-8

module PagesSchedule
  class Engine < Rails::Engine
    initializer :admin_menu_items do |app|
      PagesCore::AdminMenuItem.register("Schedule",
                                        Proc.new { admin_schedule_events_path },
                                        :pages_plugins)
    end

    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s
        config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path
        end
      end
    end
  end
end
