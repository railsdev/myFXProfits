class Alert < ActiveRecord::Base
  attr_accessible :send_number, :twil_number, :body
end
