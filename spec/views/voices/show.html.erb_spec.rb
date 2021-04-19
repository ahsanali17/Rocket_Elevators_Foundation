require 'rails_helper'

RSpec.describe "voices/show", type: :view do
  before(:each) do
    @voice = assign(:voice, Voice.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
