require 'rspec'
require './lib/models'

describe "Locations from Postal Codes" do
  it 'should return lat lng in a hash' do
    Location.from_postalcode('')[:lat].should == "0"
    Location.from_postalcode('')[:lng].should == "0"    
  end
  it 'should lookup a postcode' do
    Location.from_postalcode('90210').should == {:lat => "34.1030032", :lng => "-118.4104684"}
  end

  it 'should lookup a canadian postcode' do
    Location.from_postalcode('V5T2A4').should == {:lat => "49.261455", :lng => "-123.092197"}
  end

end

