class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def prelink_connect
    @prelink = PreLinkService.new
  end
end
