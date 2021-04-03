require 'rails_helper'

RSpec.describe Quote, type: :model do
    let(:quote) {
        Quote.new(
            company_name: "The Doll House",
            contact_name: "Dolly Parton",
            email: "Dolly@email.com",
            product_line: "Standard",
            installation_fee: "0",
           
            sub_total: "0",
            total: "0",
            building_type: "Residential",
            num_of_floors: 1,
            num_of_apartments: 0,
            num_of_basements: 0,
            num_of_parking_spots: 0,
            num_of_distinct_businesses: 0,
            num_of_elevator_cages: 0,
            num_of_occupants_per_Floor: 0,
            num_of_activity_hours_per_day: 0,
            required_columns: 0,
            required_shafts: 0
       )
    }

    it 'simple validity test' do
        expect(quote).to be_valid
    end

    it 'will test all the string type columns' do
        quote.company_name = "The Doll House"
        quote.contact_name = "Dolly Parton"
        quote.email = "Dolly@email.com"
        quote.product_line = "Standard"
        quote.sub_total = "0"
        quote.total = "0"
        quote.building_type = "Residential"
        
        expect(quote.company_name).to eq "The Doll House"
        expect(quote.contact_name).to eq "Dolly Parton"
        expect(quote.email).to eq "Dolly@email.com"
        expect(quote.product_line).to eq "Standard"
        expect(quote.sub_total).to eq "0"
        expect(quote.total).to eq "0"
        expect(quote.building_type).to eq "Residential"
    end

    it 'will test all the integer type columns' do
        quote.num_of_floors = 1
        quote.num_of_apartments = 0
        quote.num_of_basements = 0
        quote.num_of_parking_spots = 0
        quote.num_of_distinct_businesses = 0
        quote.num_of_elevator_cages = 0
        quote.num_of_occupants_per_Floor = 0
        quote.num_of_activity_hours_per_day = 0
        quote.required_columns = 0
        quote.required_shafts = 0

        expect(quote.num_of_floors).to eq 1
        expect(quote.num_of_apartments).to eq 0
        expect(quote.num_of_basements).to eq 0
        expect(quote.num_of_parking_spots).to eq 0
        expect(quote.num_of_distinct_businesses).to eq 0
        expect(quote.num_of_elevator_cages).to eq 0
        expect(quote.num_of_occupants_per_Floor).to eq 0
        expect(quote.num_of_activity_hours_per_day).to eq 0
        expect(quote.required_columns).to eq 0
        expect(quote.required_shafts).to eq 0
    end
end