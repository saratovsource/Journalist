require 'spec_helper'

describe JournalArticle do
  it 'should have a valid factory' do
    FactoryGirl.build(:journal_article).should be_valid
  end
  
  it "should have fullpath" do
    @journal_article = FactoryGirl.build(:journal_article)
    @journal_article.save
    @journal_article.fullpath.should_not be_empty
    @journal_article.fullpath.should eq("/rubric-1/article-1")
  end
end