require 'spec_helper'

describe "Links retrivers" do
  before do
    @text = <<EOF
    
    Did this website just save you a trip to the bookstore? Please make a donation to support this site, and you'll get a lifetime of advertisement-free access to this site!

    Page URL: http://www.Regular-Expressions.info/ruby.html
    Page last updated: 22 September 2010
    Site last updated: 02 February 2012
    Copyright 2003-2012 Jan Goyvaerts. All rights reserved.
    
    Google link: http://google.com with links
    Journalist link http://localhost:8080/collections/test_collection/my_photo.png is not valid link

EOF
  @route_link_browser = Journalist::TextUtils::RouteLinksBrowser.new(@text)
  end
  
  it "does retrive links array" do
    links = Journalist::TextUtils::LinksBrowser.new(@text)
    links.should have(2).items
  end
  
  it "Testing Route Blowser" do
    uris = @route_link_browser.instance_eval{ retrive_uris }
    uris.should have(2).items
    uris.each{|uri| uri.should be_an_instance_of URI::HTTP}
  end
  
end