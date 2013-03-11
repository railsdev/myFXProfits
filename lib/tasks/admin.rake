task :admin, [:name] => [:environment] do |t, args|
	puts args[:name]
	@user = User.find_by_name(args[:name])
	@user.admin = true
	@user.save!
end