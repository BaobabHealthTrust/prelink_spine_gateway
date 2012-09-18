WashOutSample::Application.routes.draw do
  root :to => 'welcome#index'
  match "order_request/:id" => "patients#order_request", :constraints => { :id => /\d+/ }
  match "show/:id" => "patients#show", :constraints => { :id => /\d+/ }
  match "show/overview/:id" => "patients#overview", :constraints => { :id => /\d+/ }
  match "show/orders/:id" => "patients#orders", :constraints => { :id => /\d+/ }
  match "show/results/:id" => "patients#results", :constraints => { :id => /\d+/ }
  match "place_order" => "patients#place_order"
  match "update_results" => "patients#check_results"
  wash_out :prelink
end