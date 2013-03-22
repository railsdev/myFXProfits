class PagesController < ApplicationController
	before_filter :session_exists, :only => [:admin]
	def admin
	end
end
