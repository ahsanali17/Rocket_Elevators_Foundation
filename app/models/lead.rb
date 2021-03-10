class Lead < ApplicationRecord
    require 'sendgrid-ruby'
    include SendGrid

end
