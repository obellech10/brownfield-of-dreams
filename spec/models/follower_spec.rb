require "rails_helper"

describe Follower do
  it "exists" do
    attrs = {
      login: "Tay James",
      html_url: "https://github.com/tayjames"
    }

    follower = Follower.new(attrs)

    expect(follower).to be_a Follower
    expect(follower.login).to eq("Tay James")
    expect(follower.html_url).to eq("https://github.com/tayjames")
  end
end
