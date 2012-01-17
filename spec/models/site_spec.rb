require 'spec_helper'

describe Site do
  it 'should have a valid factory' do
    site = FactoryGirl.build(:site)
    site.should be_valid
  end
  
  ## Validations ##
  
  it 'should validate presence of name' do
    site = FactoryGirl.build(:site, :name => nil)
    site.should_not be_valid
    site.errors[:name].should == ["can't be blank"]
  end
  
  it 'should validate presence of subdomain' do
    site = FactoryGirl.build(:site, :subdomain => nil)
    site.should_not be_valid
    site.errors[:subdomain].should == ["can't be blank"]
  end
end