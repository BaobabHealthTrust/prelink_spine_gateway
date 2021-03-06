WashOutSample::Application.routes.draw do
  root :to => 'welcome#index'
  match "order_request/:id" => "patients#order_request", :constraints => { :id => /\d+/ }
  match "check_by_date/:id" => "patients#check_by_date", :constraints => { :id => /\d+/ }
  match "show/:id" => "patients#show", :constraints => { :id => /\d+/ }
  match "show/overview/:id" => "patients#overview", :constraints => { :id => /\d+/ }
  match "show/orders/:id" => "patients#orders", :constraints => { :id => /\d+/ }
  match "show/results/:id" => "patients#results", :constraints => { :id => /\d+/ }
  match "place_order" => "patients#place_order"
  match "check_result_by_date" => "patients#check_result_by_date"
  match "check_results" => "patients#check_results"
  match "query" => "patients#query_new_results"
  match "void/:id" => "patients#void"
  match "print_ord/:id" => "patients#print_order"
  match "print/:id" => "patients#print", :constraints => { :id => /\d+((;\d+)+)?/ }
  wash_out :prelink
end