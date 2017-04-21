require 'station'

describe Station do

it "has a #name" do
  expect(Station).to respond_to :name
end

it "has a #zone" do
s1 = Station.new("Aldgate", 1)
 expect(s1.zone).to eq 1
end

end
