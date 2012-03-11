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
end