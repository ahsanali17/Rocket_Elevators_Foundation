class WarehouseRecord < ActiveRecord::Base
  self.abstract_class = true
  establish_connection :"dwh_development"
  #dwh_development for deployed site
  #warehouse_#{Rails.env} local
end
