class Intervention < ApplicationRecord
    belongs_to :employee, optional: true
    belongs_to :customer
    belongs_to :building, optional: true
    belongs_to :battery, optional: true
    belongs_to :column, optional: true
    belongs_to :elevator, optional: true
end
