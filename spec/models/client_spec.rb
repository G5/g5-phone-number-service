require 'spec_helper'

describe Client do
  it "Enforces unique URNs" do
    Client.create!(name: "Something", urn: "abc123")
    Client.new(name: "Something Else", urn: "abc123").should_not be_valid
  end

  it "requires a URN" do
    Client.new(name: "Something").should_not be_valid
  end

  it "prevents deletion of clients with locations" do
    client = Client.create!(name: "Something", urn: "abc123")
    Fabricate(:location, client_id: client.id)
    expect(client.destroy).to be_false
  end
end
