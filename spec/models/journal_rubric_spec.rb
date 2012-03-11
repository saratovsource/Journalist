require 'spec_helper'

describe JournalRubric do
  it 'should have a valid factory' do
    FactoryGirl.build(:journal_rubric).should be_valid
  end
  
  it "should have router" do
    journal_rubric = FactoryGirl.create(:journal_rubric)
    journal_rubric.router.should_not be_nil
    journal_rubric.router.fullpath.should eql("/test_rubric")
  end
  
  describe "Render" do
    before(:each) do
      @journal_rubric = FactoryGirl.create(:journal_rubric)
    end
    
    it "should have render method" do
      @journal_rubric.should respond_to(:render)
    end
    
    it "should render test page" do
      @journal_rubric.render(:page).should include(@journal_rubric.title)
    end
  end
end