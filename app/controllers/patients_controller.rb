require 'pre_link_service'

class PatientsController < ApplicationController
  before_filter :prelink_connect, :except => [:void]
  
  def order_request
    @patient = Spine::Patient.find(params[:id]) rescue nil

    redirect_to "/" if @patient.nil?
    
    @name = @patient.person.name rescue ""

    @first_name = @patient.person.names.first.given_name rescue ""
    @last_name = @patient.person.names.first.family_name rescue ""
    @national_id = @patient.national_id(false) # rescue ""
    @age = @patient.person.age rescue ""
    @dob = @patient.person.birthdate rescue ""
    @gender = @patient.person.gender rescue ""

    tmp = @prelink.get_test_codes

    @codes = []

    tmp.each do |key, value|
      @codes << [key, value] if !value.blank?
    end

  end

  def place_order
    options = {
      :priority_code => params["PriorityCode"],
      :date_collected => params["DateCollected"],
      :date_received => params["DateCollected"],
      :folio_number => params["FolioNumber"],
      :first_name => params["FirstName"],
      :last_name => params["LastName"],
      :national_id => params["NationalId"],
      :age => params["Age"],
      :dob => params["Dob"],
      :gender => params["Gender"],
      :doctor_location_code => params["DoctorLocationCode"],
      :test_codes => (params["TestCodes"] rescue [])
    }

    @order = LabOrder.create(
      :national_id => params["NationalId"],
      :priority_code => params["PriorityCode"],
      :date_collected => params["DateCollected"],
      :date_received => params["DateReceived"],
      :patient_id => params["PatientId"],
      :test_code => params["TestCodes"].join("|")
    )

    @result = @prelink.order_request(options)

    @order.update_attributes(
      :request_number => @result[:request_number],
      :barcodes => @result[:barcodes]
    )

    redirect_to "/show/#{@order.patient_id}"

  end

  def show    
    @patient = Spine::Patient.find(params[:id]) rescue nil

    @name = @patient.person.name rescue ""

    @first_name = @patient.person.names.first.given_name rescue ""
    @last_name = @patient.person.names.first.family_name rescue ""
    @national_id = @patient.national_id_with_dashes(false) rescue ""
    @age = @patient.person.age rescue ""
    @dob = @patient.person.birthdate rescue ""
    @gender = @patient.person.gender rescue ""

    @orders = LabOrder.find(:all, :conditions => ["patient_id = ?", @patient.id]) rescue []

    @open = []
    @closed = []

    @orders.each do |order|
      if order.result.blank?
        @open << order
      else
        @closed << order
      end
    end

    @cancel_destination_root_url =
      YAML.load_file("#{Rails.root}/config/application.yml")["#{Rails.env}"]["cancel_destination_root_url"] rescue ""
    
  end

  def overview
    @patient = Spine::Patient.find(params[:id]) rescue nil

    @name = @patient.person.name rescue ""

    @first_name = @patient.person.names.first.given_name rescue ""
    @last_name = @patient.person.names.first.family_name rescue ""
    @national_id = @patient.national_id_with_dashes(false) rescue ""
    @age = @patient.person.age rescue ""
    @dob = @patient.person.birthdate rescue ""
    @gender = @patient.person.gender rescue ""

    @orders = LabOrder.find(:all, :conditions => ["patient_id = ? AND DATE(timestamp) = ?",
        @patient.id, (session[:datetime] ? session[:datetime].to_date.strftime("%Y-%m-%d") :
            Date.today.strftime("%Y-%m-%d"))]) rescue []
    
    tmp = @prelink.get_test_codes

    @codes = {}

    tmp.each do |key, value|
      @codes[value] = key if !value.blank?
    end

    render :layout => false
  end

  def orders
    @patient = Spine::Patient.find(params[:id]) rescue nil

    @orders = LabOrder.find(:all, :conditions => ["patient_id = ?", @patient.id]) rescue []

    @open = []

    @orders.each do |order|
      if order.result.blank?
        @open << order
      end
    end

    @codes = {}

    tmp = @prelink.get_test_codes

    tmp.each do |key, value|
      @codes[value] = key if !value.blank?
    end

    render :layout => false
  end

  def results
    @patient = Spine::Patient.find(params[:id]) rescue nil

    @orders = LabOrder.find(:all, :conditions => ["patient_id = ?", @patient.id]) rescue []

    @closed = []

    @orders.each do |order|
      if !order.result.blank?
        @closed << order
      end
    end

    @codes = {}

    tmp = @prelink.get_test_codes

    tmp.each do |key, value|
      @codes[value] = key if !value.blank?
    end

    render :layout => false
  end

  def check_results
    results = @prelink.get_new_results

    results.each do |result|
      order = LabOrder.find_by_request_number(result[:request_number]) rescue nil

      order.update_attributes(
        :result => result[:result],
        :test_unit => result[:test_unit],
        :colour => result[:colour],
        :date_result_received => Time.now
      ) if !order.nil?
    end    

    render :text => results.length rescue 0
  end

end
