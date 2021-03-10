class Lead < ApplicationRecord
    
    after_save :create_lead_ticket
         
end
