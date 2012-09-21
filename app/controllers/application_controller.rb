class ApplicationController < ActionController::Base
  protect_from_forgery

  def print_and_redirect(print_url, redirect_url, message = "Printing, please wait...", show_next_button = false, patient_id = nil)
    @print_url = print_url
    @redirect_url = redirect_url
    @message = message
    @show_next_button = show_next_button
    @patient_id = patient_id
    render :template => 'print/print', :layout => nil
  end

  private

  def prelink_connect
    @prelink = PreLinkService.new
  end
end
