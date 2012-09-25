Pre-Link Spine Gateway
----------------------

This is an intermediary module that connects SPINE inpatient system with 
PreLink Lab Information Management System, a third party system for labs. The 
third party app has a SOAP interface exposed to the public which this module 
speaks to.

The module provides:
  1. an interface for viewing patient lab orders and the following statuses:
      a. Lab orders placed on the given day
      b. A listing of lab orders without results yet
      c. A listing of lab orders with lab results retrieved
  2. an interface for adding lab orders
  3. it automatically gets lab results from the PreLink LIMS and updates 
     the orders locally accordingly
  
SETUP
-----

To setup tha application, run the following commands:
  1. Create a "prelink.yml" similar to "prelink.yml.example" and add the relevant
        values
        
  2. Create a "database.yml" similar to "database.yml.example" and add the relevant
        values
        
  3. Create a "application.yml" similar to "application.yml.example" and add the relevant
        values
        
  4. Run $ script/patchup_spine {SPINE_PATH}
      to change Spine application to be compatible with this gateway application
      
  5. $ bundle install
  
  6. $ bundle exec rake db:create db:migrate
  
  7. Create a CRON JOB which will point to "{APPLICATION ROOT FOLDER}/script/schedule"
      e.g. "0 */2 * * *  /var/www/prelink_gateway/script/schedule"
      where the external checks are done every 2 hours
      
  8. Finally $ bundle exec rails server -p 3001
