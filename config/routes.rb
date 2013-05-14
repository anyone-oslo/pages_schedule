Rails.application.routes.draw do
  namespace :admin do
    resources :schedule_events
  end
  get 'admin/schedule_events/year/:year' => 'admin/schedule_events#index', :as => :admin_schedule_events_by_year
end
