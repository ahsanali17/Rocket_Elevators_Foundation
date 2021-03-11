class Address < ApplicationRecord
    has_one :customer
    has_one :building

    #Using the formatted_address method to generate an address in the required format.
    geocoded_by :formatted_address

    #This adds a geocode method which you can invoke via callback
    after_validation :geocode

    # Formatted_address method
    def formatted_address
        "#{number_and_street}, #{city}, #{postal_code}, #{country}"
    end

end
