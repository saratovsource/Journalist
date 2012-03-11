require 'spec_helper'

describe Journalist::TextUtils::RouteLinksBrowser do
  before(:each) do
    @journal_rubric = Factory.create(:journal_rubric)
    @site = @journal_rubric.site
    @route_link_browser = Journalist::TextUtils::RouteLinksBrowser.new(@journal_rubric.description, :site => @site)
  end
  
  it "should have one link" do
    @route_link_browser.instance_eval{ retrive_uris }.should have(1).items
  end
  
  it "should retrive Router object for this link" do
    @route_link_browser.should have(1).items
    @route_link_browser.each do |k,v|
      k.should be_instance_of(String)
      v.should be_instance_of(@journal_rubric.class)
    end
  end
  
  it "must have journal_rubric link" do
    @route_link_browser[@journal_rubric.router.fullpath].should be_eql(@journal_rubric)
  end
end