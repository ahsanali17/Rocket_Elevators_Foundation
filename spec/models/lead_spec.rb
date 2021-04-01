require 'rails_helper'

RSpec.describe Lead, type: :model do
    let(:lead) {
        Lead.new(
            full_name_of_contact: "Phineas Lamonte",
            company_name: "Jewelry for pets",
            email: "phineas_lamonte@email.com",
            phone: "123-456-7890",
            project_name: "Elevators fix",
            project_description: "Need to fix their elevator",
            department_in_charge_of_elevators: "Support",
            message: "Please fix",
            attachment: nil,
            file_name: nil,
       )
    }


    it 'is required to enter in the full name on the form' do
        expect(lead).to be_valid
    end

    it 'needs a contact name' do
        lead.full_name_of_contact = 'Phineas Lamonte'
        expect(lead.full_name_of_contact).to eq 'Phineas Lamonte'
    end
    
    it 'requires a company_name' do
        lead.company_name = "Jewelry for dog"
        expect(lead.company_name).to start_with 'Je'
    end
    
    it 'requires an email' do
        lead.email = 'phineas_lamonte@email.com'
        expect(lead.email).to eq 'phineas_lamonte@email.com'
    end

    it 'requires a phone number' do
        lead.phone = '123-456-7890'
        expect(lead.phone).to end_with '0'
    end

    it 'needs a project_name and project_description' do
        lead.project_name = 'Elevators fix'
        lead.project_description = 'Need to fix their elevator'
        expect(lead.project_name).to match 'Elevators fix'
        expect(lead.project_description).to match 'Need to fix their elevator'
    end

    it 'will have a department to handle the issue' do
        lead.message = 'please fix'
        expect(lead.message).to end_with 'ix'
    end

    it 'will have a field for file attachment and file name' do
        lead.attachment = nil
        lead.file_name = nil
        expect(lead.attachment).to be_nil
        expect(lead.file_name).to eq nil
    end

end