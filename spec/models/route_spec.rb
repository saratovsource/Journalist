require 'spec_helper'

describe Router do
  it "does route creating" do
    router = FactoryGirl.build(:router)
    router.save
    router.route_aliases.should be_empty
    
    router.slug = "test1"
    router.save
    
    router.route_aliases.should_not be_empty
  end
end