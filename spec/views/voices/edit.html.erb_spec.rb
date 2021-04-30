require 'rails_helper'

RSpec.describe "voices/edit", type: :view do
  before(:each) do
    @voice = assign(:voice, Voice.create!())
  end

  it "renders the edit voice form" do
    render

    assert_select "form[action=?][method=?]", voice_path(@voice), "post" do
    end
  end
end
