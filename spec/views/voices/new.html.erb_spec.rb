require 'rails_helper'

RSpec.describe "voices/new", type: :view do
  before(:each) do
    assign(:voice, Voice.new())
  end

  it "renders new voice form" do
    render

    assert_select "form[action=?][method=?]", voices_path, "post" do
    end
  end
end
