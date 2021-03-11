class Building < ApplicationRecord
    #belongs_to : customer
    #has_one :address
   has_many :building_details
   belongs_to :customer
   belongs_to :address
   has_many :batteries
    
end
