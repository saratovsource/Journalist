require 'spec_helper'

describe Router do
  before(:each) do
    @router = FactoryGirl.build(:router)
  end
  
  it 'should have a valid factory' do
    @router.should be_valid_verbose
  end
  
  it "should have a routerable object" do
    @router.routerable.should_not be_nil
  end
  
  it "should have full url for routerable object" do
    @router.save
    @router.fullpath.should be_eql("/collections/test_rubric")
  end
end