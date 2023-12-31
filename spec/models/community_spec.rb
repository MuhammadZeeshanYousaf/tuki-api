require 'rails_helper'

RSpec.describe Community, type: :model do
  it "is valid with a name" do
    community = Community.new(name: "Example Community")
    expect(community).to be_valid
  end

  it "is invalid without a name" do
    community = Community.new
    expect(community).to be_invalid
    expect(community.errors[:name]).to include("can't be blank")
  end
end
