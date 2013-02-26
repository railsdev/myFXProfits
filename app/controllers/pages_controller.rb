class PagesController < ApplicationController
	before_filter :session_exists, :only => [:home]
	def home 
	end

	def about 
	end

	def disclaimer
	end
end
