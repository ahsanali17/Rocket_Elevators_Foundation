class Lead < ApplicationRecord
    # SendGrid
    require 'sendgrid-ruby'
    include SendGrid
   
    after_save :create_lead_ticket
         
end
