class PagesController < ApplicationController
	skip_before_action :authenticate_user!
	skip_load_and_authorize_resource
	include HighVoltage::StaticPage
end
