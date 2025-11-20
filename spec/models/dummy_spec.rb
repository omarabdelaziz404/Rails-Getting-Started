require 'rails_helper'

RSpec.describe Dummy, type: :model do
  it "must have an age greater than 21" do
    dummy = create(:dummy)
    dummy2 = create(:dummy)
    expect(dummy.email).to eq("test+1@gmail.com")
    expect(dummy2.email).to eq("test+2@gmail.com")

  end  
end
