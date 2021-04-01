require 'spec_helper'

describe 'External request' do
  it 'will query the response recieved from rapidAPI' do
    uri = URI('https://covid-19-data.p.rapidapi.com/report/country/name?date=2020-04-01&name=Canada&date-format=YYYY-MM-DD&format=json')

    response = Net::HTTP.get(uri)

    expect(response).to be_an_instance_of(String)
  end
end