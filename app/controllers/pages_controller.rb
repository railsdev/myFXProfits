class PagesController < ApplicationController
	before_filter :session_exists, :only => [:home]
	def home
		redirect_to '/posts'
	end

	def about
	end

	def disclaimer
	end

	def plans
	end
end
