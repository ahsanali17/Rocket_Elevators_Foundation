class Quote < ApplicationRecord
  after_save :create_quote_ticket

    def create_quote_ticket
        
    end
end
