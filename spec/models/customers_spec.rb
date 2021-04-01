# require 'streamer' 
# require 'rails_helper' 
# require 'faker'
# # require 'factories'

# RSpec.describe Customers, type: :request do

#   context 'Grabs List of customers'
#   it 'returns customers list' do
#     2.times{FactoryBot.create(:customers, name: Faker::Name, email: Faker::Email)}
#     # get '/customers'
#     expect(response).to have_http_status(:success)
#     expect(JSON.parse(response.body).size).to eq(3)
#   end
# end