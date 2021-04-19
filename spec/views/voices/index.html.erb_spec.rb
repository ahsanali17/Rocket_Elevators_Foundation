require 'rails_helper'

RSpec.describe "voices/index", type: :view do
  before(:each) do
    assign(:voices, [
      Voice.create!(),
      Voice.create!()
    ])
  end

  it "renders a list of voices" do
    render
  end
end
