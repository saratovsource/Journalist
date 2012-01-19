require 'spec_helper'

describe JournalRubric do
  it 'should have a valid factory' do
    FactoryGirl.build(:journal_rubric).should be_valid
  end
  
  it "should be not valid if journal_rubric has no title" do
    @journal_rubric = FactoryGirl.build(:journal_rubric)
    @journal_rubric.title = nil
    @journal_rubric.should_not be_valid
  end
  
  it "should raise error if journal_rubric has no one site" do
    @journal_rubric = FactoryGirl.build(:journal_rubric)
    @journal_rubric.site = nil
    @journal_rubric.should_not be_valid
    lambda { 
      @journal_rubric.save!
    }.should raise_error(Mongoid::Errors::Validations, "Validation failed - Site can't be blank.")
  end
  
  it "should raise error if journal_rubric has no one site" do
    @journal_rubric = FactoryGirl.build(:journal_rubric)
    @journal_rubric.owner = nil
    @journal_rubric.should_not be_valid
    lambda { 
      @journal_rubric.save!
    }.should raise_error(Mongoid::Errors::Validations, "Validation failed - Owner can't be blank.")
  end
  
  it "should have fullpath" do
    @journal_rubric = FactoryGirl.build(:journal_rubric)
    @journal_rubric.save
    @journal_rubric.fullpath.should_not be_empty
    @journal_rubric.fullpath.should eq("/rubric-1")
  end
end