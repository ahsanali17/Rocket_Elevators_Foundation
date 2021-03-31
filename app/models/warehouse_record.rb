class WarehouseRecord < ActiveRecord::Base
  self.abstract_class = true
  establish_connection :"warehouse_#{Rails.env}"
  #dwh_development for deployed site
  #warehouse_#{Rails.env} local
end
 