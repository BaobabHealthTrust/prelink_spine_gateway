class PrelinkController < ApplicationController
  include WashOut::SOAP

  # You can use all Rails features like filtering, too. A SOAP controller
  # is just like a normal controller with a special routing.
  before_filter :dump_parameters

  def dump_parameters
    # Rails.logger.debug params.inspect
    Rails.logger.debug request.filtered_parameters.inspect
  end

  soap_action "GetResultsFromRequestNumber",
    :args   => :integer,
    :return => :string,
    :to     => :get_results_from_request_number
  def get_results_from_request_number
    render :soap => {"GetResultsFromRequestNumberResult" => params[:value].to_s}
  end

  soap_action "OrderRequest",
    :args => {
    :order_request => {
      :dto => {
        :priority_code => :string,
        :date_collected => :string,
        :date_received => :string,
        :folio_number => :string,
        :patient_first_name => :string,
        :patient_last_name => :string,
        :patient_age => :integer,
        :patient_date_of_birth => :string,
        :gender_code => :string,
        :doctor_location_code => :string,
        :test_codes => [
          :string
        ]
      }
    }
  },
    :return => 
    { :order_request_response => {
      :dto_response => {
        :priority_code_response => :string,
        :date_collected_response => :string,
        :date_received_response => :string,
        :folio_number_response => :string,
        :patient_first_name_response => :string,
        :patient_last_name_response => :string,
        :patient_age_response => :integer,
        :patient_date_of_birth_response => :string,
        :gender_code_response => :string,
        :doctor_location_code_response => :string,
        :test_codes_response => [
          :string
        ]
      }
    }
  },
    :to     => :order_request
  def order_request    
    render :soap =>
      { :ordered_request_response => {
        :dto_response => {
          :priority_code_response => request.filtered_parameters[:envelope][:body][:order_request][:dto][:priority_code],
          :date_collected_response => request.filtered_parameters[:envelope][:body][:order_request][:dto][:date_collected],
          :date_received_response => request.filtered_parameters[:envelope][:body][:order_request][:dto][:date_received],
          :folio_number_response => request.filtered_parameters[:envelope][:body][:order_request][:dto][:folio_number],
          :patient_first_name_response => request.filtered_parameters[:envelope][:body][:order_request][:dto][:patient_first_name],
          :patient_last_name_response => request.filtered_parameters[:envelope][:body][:order_request][:dto][:patient_last_name],
          :patient_age_response => request.filtered_parameters[:envelope][:body][:order_request][:dto][:patient_age],
          :patient_date_of_birth_response => request.filtered_parameters[:envelope][:body][:order_request][:dto][:patient_date_of_birth],
          :gender_code_response => request.filtered_parameters[:envelope][:body][:order_request][:dto][:gender_code],
          :doctor_location_code_response => request.filtered_parameters[:envelope][:body][:order_request][:dto][:doctor_location_code],
          :test_codes_response => [
            request.filtered_parameters[:envelope][:body][:order_request][:dto][:test_codes]
          ]
        }
      }
    }
  end

  soap_action "GetTestCodes",
    :args   => :nil,
    :return => :string,
    :to     => :get_test_codes
  def get_test_codes

    render :soap => request.filtered_parameters.to_s
  end

end
