ActionController::Routing::Routes.draw do |map|
  map.with_options :path_prefix => '/admin', :name_prefix => 'admin_' do |admin|
    admin.resources(
      :schedule_events,
      :controller => 'admin/schedule_events'
    )
  end

  map.admin_schedule_events_by_year 'admin/schedule_events/year/:year', :controller => 'admin/schedule_events', :action => 'index'
end