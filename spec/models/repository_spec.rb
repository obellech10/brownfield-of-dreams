require "rails_helper"

describe Repository do
  it "exists" do
    attrs = {
      name: "little_shop_v2",
      html_url: "https://github.com/DavisC0801"
    }

    repository = Repository.new(attrs)

    expect(repository).to be_a Repository
    expect(repository.name).to eq("little_shop_v2")
    expect(repository.html_url).to eq("https://github.com/DavisC0801")
  end
end
